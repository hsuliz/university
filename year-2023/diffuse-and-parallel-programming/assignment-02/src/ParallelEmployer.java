import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.*;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ParallelEmployer implements Employer {

    private final Map<Integer, Location> orderMap = new ConcurrentHashMap<>();
    private final BlockingQueue<Result> dataQueue = new LinkedBlockingQueue<>();
    private final ForkJoinPool forkJoinPool = new ForkJoinPool();
    private final Lock lock = new ReentrantLock();
    private final Condition condition = lock.newCondition();
    // orderID, type, allowedDirections
    private final ResultListener resultListener = result -> {
        lock.lock();
        try {
            dataQueue.put(result);
            condition.signal();
        } catch (InterruptedException e) {
            throw new RuntimeException(e);
        } finally {
            lock.unlock();
        }
    };
    private OrderInterface orderInterface;

    @Override
    public void setOrderInterface(OrderInterface order) {
        this.orderInterface = order;
        orderInterface.setResultListener(resultListener);
    }

    @Override
    public Location findExit(Location startLocation, List<Direction> allowedDirections) {
        DataConsumer consumer = new DataConsumer();
        forkJoinPool.execute(consumer);

        orderMap.put(orderInterface.order(startLocation), startLocation);

        return null;
    }

    private class DataConsumer extends RecursiveAction {
        private final Set<Location> visitedLocations = ConcurrentHashMap.newKeySet();

        @Override
        protected void compute() {
            try {
                while (true) {
                    Result result = dataQueue.take();
                    // Process the data as needed
                    System.out.println("Consumed: " + result);
                    Location location = orderMap.get(result.orderID());

                    if (visitedLocations.contains(location)) {
                        // Skip exploring if the location has already been visited
                        continue;
                    }

                    visitedLocations.add(location);

                    result.allowedDirections().forEach(direction -> {
                        forkJoinPool.execute(() -> {
                            exploreDirection(direction, location);
                        });
                    });

                    if (Objects.equals(result.type(), LocationType.EXIT)) {
                        System.out.println("Found exit!!");
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
                    var orderId = orderInterface.order(newLocation);
                    orderMap.put(orderId, newLocation);
                } finally {
                    lock.unlock();
                }
            });
        }
    }
}
