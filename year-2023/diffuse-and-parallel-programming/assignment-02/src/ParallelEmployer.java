import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ParallelEmployer implements Employer {

    private final int availableProcessors = Runtime.getRuntime().availableProcessors();
    private final ExecutorService executorService = Executors.newCachedThreadPool();
    private final HashMap<Integer, Result> map = new HashMap<>();
    private final Lock lock = new ReentrantLock();
    private final Condition condition = lock.newCondition();
    private final ResultListener resultListener = result -> {
        lock.lock();
        try {
            map.put(result.orderID(), result);
            condition.signalAll();
        } finally {
            lock.unlock();
        }
    };
    private OrderInterface orderInterface;

    @Override
    public synchronized void setOrderInterface(OrderInterface order) {
        this.orderInterface = order;
    }

    @Override
    public synchronized Location findExit(Location startLocation, List<Direction> allowedDirections) {
        ExecutorService executorService = Executors.newCachedThreadPool();

        for (int i = 0; i < 10; i++) {
            int finalI = i;
            executorService.submit(() -> {
                lock.lock();
                try {
                    orderInterface.setResultListener(resultListener);
                    var orderId = orderInterface.order(new Location(startLocation.col() - finalI, startLocation.row()));
                    while (map.get(orderId) == null) {
                        condition.await();
                    }

                    System.out.println(map.get(orderId));
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                } finally {
                    lock.unlock();
                }
            });
        }

        executorService.shutdown();
        return null;
    }
}
