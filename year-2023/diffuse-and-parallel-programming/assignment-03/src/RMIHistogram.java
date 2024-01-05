import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicInteger;

public class RMIHistogram extends UnicastRemoteObject implements RemoteHistogram, Binder {

    private final List<List<Integer>> histograms;
    private final AtomicInteger histogramId;

    public RMIHistogram() throws RemoteException {
        super();
        histograms = new CopyOnWriteArrayList<>();
        histogramId = new AtomicInteger(0);
    }

    @Override
    public void bind(String serviceName) {
        try {
            LocateRegistry.getRegistry().rebind(serviceName, this);
        } catch (RemoteException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public synchronized int createHistogram(int bins) throws RemoteException {
        int id = histogramId.getAndIncrement();
        List<Integer> histogram = new CopyOnWriteArrayList<>();
        for (int i = 0; i < bins; i++) {
            histogram.add(0);
        }
        histograms.add(histogram);
        return id;
    }

    @Override
    public synchronized void addToHistogram(int histogramID, int value) throws RemoteException {
        List<Integer> histogram = histograms.get(histogramID);
        while (value >= histogram.size()) {
            histogram.add(0);
        }
        histogram.set(value, histogram.get(value) + 1);
    }

    @Override
    public synchronized int[] getHistogram(int histogramID) throws RemoteException {
        List<Integer> histogram = histograms.get(histogramID);
        return histogram.stream().mapToInt(Integer::intValue).toArray();
    }
}
