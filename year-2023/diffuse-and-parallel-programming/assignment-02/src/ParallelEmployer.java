import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ParallelEmployer implements Employer {

    private final Set<Location> locations = ConcurrentHashMap.newKeySet();
    private final Map<Integer, Location> orderMap = new ConcurrentHashMap<>();
    private final BlockingQueue<Result> dataQueue = new LinkedTransferQueue<>();
    private final ForkJoinPool forkJoinPool = new ForkJoinPool();
    private final Set<Location> visitedLocations = ConcurrentHashMap.newKeySet();
    private final Lock lock = new ReentrantLock();
    // orderID, type, allowedDirections
    private final ResultListener resultListener = result -> {
        try {
            dataQueue.put(result);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    };
    private Location exitLocation;
    private OrderInterface orderInterface;

    @Override
    public void setOrderInterface(OrderInterface order) {
        this.orderInterface = order;
        orderInterface.setResultListener(resultListener);
    }

    @Override
    public Location findExit(Location startLocation, List<Direction> allowedDirections) {
        DataConsumer consumer = new DataConsumer();
        CountDownLatch latch = new CountDownLatch(1);
        consumer.setLatch(latch);
        forkJoinPool.execute(consumer);
        orderMap.put(orderInterface.order(startLocation), startLocation);

        try {
            latch.await();
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        return exitLocation;
    }

    private class DataConsumer implements Runnable {

        private final AtomicBoolean exitFound = new AtomicBoolean(false);
        private CountDownLatch latch;

        public void setLatch(CountDownLatch latch) {
            this.latch = latch;
        }

        @Override
        public void run() {
            try {
                while (!exitFound.get()) {
                    Result result = dataQueue.take();
                    Location location = orderMap.get(result.orderID());

                    lock.lock();
                    try {
                        if (visitedLocations.contains(location)) {
                            //visitedLocations.add(location);
                            continue;
                        }
                    } finally {
                        lock.unlock();
                    }

                    visitedLocations.add(location);

                    result.allowedDirections()
                            .forEach(direction -> forkJoinPool.execute(() -> exploreDirection(direction, location)));

                    if (Objects.equals(result.type(), LocationType.EXIT)) {
                        exitFound.set(true);
                        exitLocation = location;
                        latch.countDown();
                        break;
                    }
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }

        private void exploreDirection(Direction direction, Location location) {
            forkJoinPool.execute(() -> {
                Location newLocation = direction.step(location);
                lock.lock();
                try {
                    var directions = orderMap.values();
                    if (directions.contains(newLocation)) {
                        return;
                    }
                    var orderId = orderInterface.order(newLocation);
                    //System.out.println(Thread.currentThread() + " -> " + orderId + " -> " + newLocation);
                    orderMap.put(orderId, newLocation);
                } finally {
                    lock.unlock();
                }
            });
        }
    }
}
