import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Loops implements GeneralLoops {
    private final List<List<Integer>> outStream = new ArrayList<>();
    private List<Integer> uppLim;
    private List<Integer> lowerLim;

    @Override
    public void setLowerLimits(List<Integer> limits) {
        lowerLim = new ArrayList<>(limits);
    }

    @Override
    public void setUpperLimits(List<Integer> limits) {
        uppLim = new ArrayList<>(limits);
    }

    @Override
    public List<List<Integer>> getResult() {
        //check NULL
        if (uppLim == null) {
            if (lowerLim == null) {
                lowerLim = new ArrayList<>();
                lowerLim.add(0);
            }
            uppLim = new ArrayList<>();
            for (int i = 0; i < lowerLim.size(); i++) {
                uppLim.add(0);
            }
        } else if (lowerLim == null) {
            lowerLim = new ArrayList<>();
            for (int i = 0; i < uppLim.size(); i++) {
                lowerLim.add(0);
            }
        }

        //set up
        List<Integer> tempList = new ArrayList<>(lowerLim);
        outStream.add(new ArrayList<>(tempList));
        int counter = tempList.size() - 1;
        //main
        for (int i = counter; counter >= 0; i--) {
            if (Objects.equals(tempList.get(counter), uppLim.get(counter))) {
                tempList.set(counter, lowerLim.get(counter));
                counter--;
            } else {
                tempList.set(counter, tempList.get(counter) + 1);
                outStream.add(new ArrayList<>(tempList));
                counter = tempList.size() - 1;
            }
        }
        return outStream;
    }
}