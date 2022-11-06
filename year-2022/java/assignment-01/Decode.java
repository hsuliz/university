import java.util.ArrayList;

class Decode extends DecoderInterface {
    private final ArrayList<Integer> mainData = new ArrayList<>();
    private String mainOut = "";
    private int basedX = 0;
    private int temp = 0;

    int getBasedX() {
        return basedX;
    }

    @Override
    public void input(int bit) {
        mainData.add(bit);
    }

    @Override
    public String output() {
        // find x
        for (Integer tempInt : mainData) {
            if (tempInt == 1) {
                basedX++;
            } else if (basedX > 0 && tempInt == 0) {
                break;
            }
        }

        for (Integer basedDatum: mainData) {
            if (basedDatum == 1) {
                temp++;
            } else if (temp > 0 && basedDatum == 0) {
                mainOut += (char) temp / basedX - 1;
                temp = 0;
            }
        }
        return mainOut;
    }

    @Override
    public void reset() {
        mainOut = "";
        basedX = 0;
        mainData.clear();
    }
}