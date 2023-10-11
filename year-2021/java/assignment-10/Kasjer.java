import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;
import java.util.function.Supplier;

public class Kasjer implements KasjerInterface {
    List<Pieniadz> basedStatus = new ArrayList<>();
    List<Pieniadz> cashStatus;
    List<Pieniadz> returnStatus = new ArrayList<>();
    List<Pieniadz> payed = new LinkedList<>();
    // changer, idk how it should work
    RozmieniaczInterface changer;
    boolean anotherrDude = true;

    @Override
    public List<Pieniadz> rozlicz(int cena, List<Pieniadz> pieniadze) {
        anotherrDude = false;
        List<Pieniadz> fullStatus = new ArrayList<>();
        fullStatus.addAll(pieniadze);
        fullStatus.addAll(basedStatus);
        List<Pieniadz> rMoneyList = new LinkedList<>();
        List<Pieniadz> nrMoneyList = new LinkedList<>();
        cashStatus = new ArrayList<>();

        for (var p : fullStatus) {
            if (p.czyMozeBycRozmieniony()) {
                rMoneyList.add(p);
            } else {
                nrMoneyList.add(p);
            }
        }

        // count delta //

        int basedCounter = 0;
        for (Pieniadz status : basedStatus) {
            basedCounter += status.wartosc();
        }
        int inputStatus = 0;
        for (Pieniadz pieniadz : pieniadze) {
            inputStatus += pieniadz.wartosc();
        }
        int returnCounter = inputStatus - cena;

        // no stupid money //


        // change is equal
        if (returnCounter == 0) {
            System.out.println("YA TUTA");
            cashStatus.addAll(basedStatus);
            cashStatus.addAll(pieniadze);
            returnStatus.clear();
            return returnStatus;
        }

        // based can return everything
        boolean bruh = true;
        if (returnCounter <= basedCounter) {
            // check if I have bad money
            for (Pieniadz status : basedStatus) {
                if (!status.czyMozeBycRozmieniony()) {
                    bruh = false;
                    break;
                }
            }

            // no bad money //
            if (bruh) {
                int countInput = 0;
                int rCountInput = 0;

                for (Pieniadz pieniadz : nrMoneyList) {
                    countInput += pieniadz.wartosc();
                }

                if (countInput > cena) {
                    returnStatus.addAll(pieniadze);
                    basedStatus = changerFun(basedStatus);
                    alsoMoneyDude(returnCounter, basedStatus);
                    return returnStatus;
                }


                basedStatus = changerFun(basedStatus);
                System.out.println(basedStatus);
                moneyDude(pieniadze, returnCounter, basedStatus);
                return returnStatus;

            } else {

                // sort stupid money
                nrMoneyList.sort(Comparator.comparingInt(Pieniadz::wartosc));
                rMoneyList = changerFun(rMoneyList);
                // if I have cash
                if (basedCounter == returnCounter) {
                    System.out.println(cashStatus);
                    iHateNrMoney(rMoneyList, returnCounter);
                    cashStatus.addAll(nrMoneyList);
                    System.out.println(cashStatus);
                    return returnStatus;
                } else {
                    moneyDude(nrMoneyList, returnCounter, rMoneyList);
                }
            }
        }

        // based can't return all


        // stupid money ;( //

        // divide in 2 arrays //
        // sorting
//        List<Pieniadz> fullStatus = new ArrayList<>();
//        List<Pieniadz> rMoneyList = new LinkedList<>();
//        List<Pieniadz> nrMoneyList = new LinkedList<>();
//        for (var p : fullStatus) {
//            if (p.czyMozeBycRozmieniony()) {
//                rMoneyList.add(p);
//            } else {
//                nrMoneyList.add(p);
//            }
//        }
//        // sort stupid money
//        nrMoneyList.sort(Comparator.comparingInt(Pieniadz::wartosc));


        return returnStatus;
    }

    private void iHateNrMoney(List<Pieniadz> rMoneyList, int returnCounter) {
        int i;
        for (i = 0; i < returnCounter; i++) {
            returnStatus.add(rMoneyList.get(i));
        }
        for (int j = i; j < rMoneyList.size(); j++) {
            cashStatus.add(rMoneyList.get(j));
        }
    }

    private void alsoMoneyDude(int returnCounter, List<Pieniadz> basedStatus) {
        iHateNrMoney(basedStatus, returnCounter);
    }

    private void moneyDude(List<Pieniadz> pieniadze, int returnCounter, List<Pieniadz> basedStatus) {
        alsoMoneyDude(returnCounter, basedStatus);
        int counter = 0;
        int counterx = 0;
        for (Pieniadz status : cashStatus) {
            counter += status.wartosc();
        }
        for (Pieniadz status : returnStatus) {
            counterx += status.wartosc();
        }
        System.out.println("Return money: " + counterx);
        System.out.println("Cash money: " + counter);
        cashStatus.addAll(pieniadze);
    }


    @Override
    public List<Pieniadz> stanKasy() {
        if(anotherrDude) {
            cashStatus = basedStatus;
        }
        //System.out.println(returnStatus);
        System.out.println(cashStatus);
        return cashStatus;
    }

    private List<Pieniadz> changerFun(List<Pieniadz> whatToChange) {
        dostępDoRozmieniacza(changer);
        for (int i = 0; i < 100000; i++) {
            List<Pieniadz> tmp = new ArrayList<>();
            for (var p :
                    whatToChange) {
                if (p.wartosc() == 1) {
                    tmp.add(p);
                    continue;
                }
                tmp.addAll(changer.rozmien(p));
            }
            whatToChange = new ArrayList<>(tmp);
        }
        return whatToChange;
    }

    @Override
    public void dostępDoRozmieniacza(RozmieniaczInterface rozmieniacz) {
        this.changer = rozmieniacz;
    }

    @Override
    public void dostępDoPoczątkowegoStanuKasy(Supplier<Pieniadz> dostawca) {
        Pieniadz aha = dostawca.get();
        for (; aha != null; aha = dostawca.get()) {
            basedStatus.add(aha);
        }
        //System.out.println(moneyStatus);
    }


    // UTILITY STUFF //
    private void printAll() {
        int x = 0, y = 0;
        for (Pieniadz status : cashStatus) {
            x += status.wartosc();
        }
        for (Pieniadz pieniadz : returnStatus) {
            y += pieniadz.wartosc();
        }
        if (x == 0) {
            System.out.println("CashStatus: nig im empty");
        } else {
            System.out.println("CashStatus: " + x);
        }
        if (y == 0) {
            System.out.println("moneyReturn: nig im empty");
        } else {
            System.out.println("moneyReturn: " + y);
        }
    }
}

