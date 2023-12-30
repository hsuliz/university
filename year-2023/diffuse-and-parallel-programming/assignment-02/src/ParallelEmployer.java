import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.*;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ParallelEmployer implements Employer {

    private final Map<Integer, Location> orderMap = new ConcurrentHashMap<>();
    private final BlockingQueue<Result> dataQueue = new LinkedTransferQueue<>();
    private final ExecutorService executorService = Executors.newCachedThreadPool();
    private final ConcurrentHashMap<Location, Boolean> visitedLocations = new ConcurrentHashMap<>();
    private final Lock lock = new ReentrantLock();
    private final ResultListener resultListener = this::putResultToQueue;
    private Location exitLocation;
    private OrderInterface orderInterface;

    @Override
    public void setOrderInterface(OrderInterface order) {
        this.orderInterface = order;
        orderInterface.setResultListener(resultListener);
    }

    @Override
    public Location findExit(Location startLocation, List<Direction> allowedDirections) {
        CountDownLatch latch = new CountDownLatch(1);
        DataConsumer consumer = new DataConsumer(latch);
        executorService.submit(consumer);
        orderMap.put(orderInterface.order(startLocation), startLocation);
        waitForExit(latch);
        return exitLocation;
    }

    private void waitForExit(CountDownLatch latch) {
        try {
            latch.await();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } finally {
            executorService.shutdown();
        }
    }

    private void putResultToQueue(Result result) {
        try {
            dataQueue.put(result);
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        }
    }

    private class DataConsumer implements Runnable {

        private final AtomicBoolean exitFound = new AtomicBoolean(false);
        private final CountDownLatch latch;

        public DataConsumer(CountDownLatch latch) {
            this.latch = latch;
        }

        @Override
        public void run() {
            while (!exitFound.get()) {
                Result result = getResult();
                Location location = orderMap.get(result.orderID());

                if (isVisited(location)) {
                    continue;
                }

                result.allowedDirections()
                        .forEach(direction -> executorService.submit(() -> exploreDirection(direction, location)));

                if (Objects.equals(result.type(), LocationType.EXIT)) {
                    exitFound.set(true);
                    exitLocation = location;
                    latch.countDown();
                }
            }
        }

        private Result getResult() {
            Result result;
            try {
                result = dataQueue.take();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            return result;
        }

        private boolean isVisited(Location location) {
            return visitedLocations.putIfAbsent(location, true) != null;
        }

        private void exploreDirection(Direction direction, Location location) {
            executorService.submit(() -> {
                Location newLocation = direction.step(location);
                lock.lock();
                try {
                    if (orderMap.containsValue(newLocation)) {
                        return;
                    }
                    var orderId = orderInterface.order(newLocation);
                    orderMap.put(orderId, newLocation);
                } finally {
                    lock.unlock();
                }
            });
        }
    }
}
