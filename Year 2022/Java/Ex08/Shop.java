import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

class Shop implements ShopInterface {

    Map<String, Integer> wareHouse = new HashMap<>();
    Map<String, Object> waitingRoom = new HashMap<>();
    List<String> wareHouseStringList;

    @Override
    public void delivery(Map<String, Integer> goods) {
        wareHouseStringList = new ArrayList<>(goods.keySet());
        Integer val;





        for (String s : goods.keySet()) {
            synchronized (this) {
                if (wareHouse.get(s) != null) {
                    val = wareHouse.get(s) + goods.get(s);
                    wareHouse.put(s, val);
                } else {
                    wareHouse.put(s, goods.get(s));
                    // WHY WONT WORK>?"FE<SLVEF<SD
                    // waitingRoom.computeIfAbsent(s, k -> new Object());
                    // this works ok
                    waitingRoom.computeIfAbsent(s, k -> new Object());
                    synchronized (waitingRoom.get(s)) {
                        waitingRoom.get(s).notifyAll();
                    }
                }
            }
        }
    } 

    @Override
    public boolean purchase(String productName, int quantity) {
        waitingRoom.computeIfAbsent(productName, k -> new Object());
        synchronized (waitingRoom.get(productName)) {
            if (wareHouse.get(productName) != null && wareHouse.get(productName) >= quantity) {
                wareHouse.put(productName, wareHouse.get(productName) - quantity);
                return true;
            } else {
                try {
                    // waiting
                    waitingRoom.get(productName).wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                if (wareHouse.get(productName) == null) {
                    return false;
                } else if (wareHouse.get(productName) >= quantity) {
                    wareHouse.put(productName, wareHouse.get(productName) - quantity);
                    return true;
                }
            }
            return false;
        }
    }

    @Override
    public Map<String, Integer> stock() {
        return wareHouse;
    }
}