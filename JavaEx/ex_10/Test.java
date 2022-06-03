import java.util.*;
import java.util.stream.Collectors;

class Rozmieniacz implements RozmieniaczInterface {
    // list of serial numbers processed by rozmieniacz - they should not appear
    // anywhere or the Kasjer duped money
    public List<Integer> serialNumbers = new LinkedList<Integer>();
    List<Integer> nominaly = Arrays.stream(Nominal.values()).map(n -> n.wartość()).collect(Collectors.toList());
    Random rand = new Random(2137);

    /**
     * Maps pieniadze to serial numbers
     *
     * @param pieniadze
     * @return
     */
    public static List<Integer> MapPtoSN(List<Pieniadz> pieniadze) {
        return pieniadze.stream().map(Pieniadz::numerSeryjny).collect(Collectors.toList());
    }

    // same as below but automatic mapping Pieniadz::numerSeryjny
    public void serialNumberCheck2(List<Pieniadz> serials, List<Pieniadz> anyExtraSerials) {
        serialNumberCheck(MapPtoSN(serials), MapPtoSN(anyExtraSerials));
    }

    /**
     * Checks list of serial numbers for duplicates and also against second list and
     * internal list.
     *
     * @param serials         list of serial numbers to check
     * @param anyExtraSerials extra list to check against
     */
    public void serialNumberCheck(List<Integer> serials, List<Integer> anyExtraSerials) {
        if (serials.stream().collect(Collectors.toSet()).size() < serials.size())
            throw new RuntimeException("Found duplicate serial numbers in the list");

        List<Integer> common = new ArrayList<Integer>(this.serialNumbers.size() + anyExtraSerials.size());
        Collections.copy(common, this.serialNumbers);
        if (anyExtraSerials != null)
            common.addAll(anyExtraSerials);

        common.retainAll(serials);
        if (common.size() > 0)
            throw new RuntimeException("Found " + common.size() + " duplicate serial numbers in the list");

        // System.out.println("No duplicate serial numbers found");
    }

    @Override
    public List<Pieniadz> rozmien(Pieniadz coin) {
        if (serialNumbers.contains(coin.numerSeryjny()))
            throw new RuntimeException("Serial number " + coin.numerSeryjny() + " appeared twice - money was duped");

        if (coin.wartosc() == 1)
            throw new RuntimeException("Spróbowano rozmienić pieniądz ZŁ1");

        if (!coin.czyMozeBycRozmieniony())
            throw new RuntimeException("Spróbowano rozmienić pieniądz nierozmienialny");

        List<Pieniadz> result = new LinkedList<Pieniadz>();

        int bound = nominaly.indexOf(coin.wartosc());
        int remainingValue = coin.wartosc();

        // randomly generate smaller nominals
        while (remainingValue > 0) {
            int index = rand.nextInt(bound);
            int val = nominaly.get(index);
            // if nominal to high, set it as limit for next random
            if (val > remainingValue) {
                bound = index;
            } else {
                result.add(new Pieniadz(Nominal.values()[index], Rozmienialnosc.TAK));
                remainingValue -= val;
            }
        }

        return result;
    }

}

public class Test {
    public static void main(String[] args) {
        Kasjer k = new Kasjer();
        Rozmieniacz r = new Rozmieniacz();
        k.dostępDoRozmieniacza(r);
        List<Pieniadz> pieniadzList = new ArrayList<>();
        pieniadzList.add(new Pieniadz(Nominal.Zł50, Rozmienialnosc.NIE));
        pieniadzList.add(new Pieniadz(Nominal.Zł20, Rozmienialnosc.TAK));


        k.dostępDoPoczątkowegoStanuKasy(new Sup(new Pieniadz[]{new Pieniadz(Nominal.Zł5, Rozmienialnosc.NIE)}));
        k.stanKasy();
    }
}
