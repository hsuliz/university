import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.*;

// size 500 x 500

public class Start {

    // size of frame
    final Dimension mySize = new Dimension(500, 500);

    // stuff
    JFrame myFrame;
    JButton myLoadButton;
    DrawingMoment myPaint;
    Points myPoints;
    Lines myLines;
    Normalisation myNormalisationPoints;
    NormalisationThickness myNormalisationThickness;

    // data storage
    List<Integer> pointsListX;
    List<Integer> pointsListY;
    List<Integer> thickList;
    List<Integer> xList, yList;


    public static void main(String[] args) {
        Start graphCreator = new Start();
        graphCreator.graphSetup();
    }

    // main method
    private void graphSetup() {

        // frame setup
        myFrame = new JFrame("Graph drawer");
        myFrame.setSize(mySize);
        myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        // pos in middle
        myFrame.setLocationRelativeTo(null);

        // button
        myLoadButton = new JButton("Load");
        myLoadButton.addActionListener(new HornyButton());


        // drawing
        myPaint = new DrawingMoment();


        // adding
        myFrame.getContentPane().add(BorderLayout.NORTH, myLoadButton);
        myFrame.getContentPane().add(BorderLayout.CENTER, myPaint);
        myFrame.setVisible(true);
    }


    private void dataSucker(File input) {
        //System.out.println("IM DATA SUCKER");
        try {
            Scanner reader = new Scanner(input);

            // points //
            myPoints = new Points(reader.nextInt());
            int x, y;
            myNormalisationPoints = new Normalisation();
            for (int i = 0; i < myPoints.numberOfPoints; i++) {
                x = reader.nextInt();
                y = reader.nextInt();
                myNormalisationPoints.addDataToBuff(x, y);
            }

            myNormalisationPoints.calculateNorm();

            for (int i = 0; i < myPoints.numberOfPoints; i++) {
                myPoints.setPoints(myNormalisationPoints.getX(i), myNormalisationPoints.getY(i));
            }

            //myPoints.printAllData();
            // skips number of whatever
            int sizeOfLines = reader.nextInt();

            // lines //
            thickList = new ArrayList<>();
            myLines = new Lines();
            myNormalisationThickness = new NormalisationThickness();

            xList = new ArrayList<>();
            yList = new ArrayList<>();
            for (int i = 0; i < sizeOfLines; i++) {
                xList.add(reader.nextInt());
                yList.add(reader.nextInt());
                thickList.add(reader.nextInt());
            }

            for (int i = 0; i < sizeOfLines; i++) {
                myNormalisationThickness.addDataToBuff(thickList.get(i));
            }
            myNormalisationThickness.calculateNorm();
            //System.out.println(xList);
            //System.out.println(yList);
            //System.out.println(thickList);
            myNormalisationThickness.printAll();

            for (int i = 0; i < sizeOfLines; i++) {
                x = xList.get(i);
                y = yList.get(i);
                myLines.linesAdder(x, y, (int) myNormalisationThickness.getX(i));
            }

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        System.out.println(myPoints.numberOfPoints);
        System.out.println(myLines.getSize());


//        World if individuals couldn't use nextInt

//        // sorting
//        myPoints = new Points(Integer.parseInt(dataString.get(0)));
//        System.out.println(myPoints.numberOfPoints);
//
//        // dividing points //
//
//        // for x and y
//        int x, y;
//        for (int i = 0; i < myPoints.numberOfPoints; i++) {
//            x = Character.getNumericValue(dataString.get(i + 1).charAt(0));
//            y = Character.getNumericValue(dataString.get(i + 1).charAt(2));
//            myPoints.pointsAdder(x, y);
//        }
//        myPoints.printAllData();

    }


    // action listener dude
    class HornyButton implements ActionListener {
        @Override
        public void actionPerformed(ActionEvent e) {
            if (e.getSource() == myLoadButton) {
                JFileChooser fileChooser = new JFileChooser();
                // dialog for file choose
                int response = fileChooser.showOpenDialog(null);
                // response is true
                if (response == JFileChooser.APPROVE_OPTION) {
                    // gets path
                    File inputFile = new File(fileChooser.getSelectedFile().getAbsolutePath());
                    dataSucker(inputFile);
                }
            }
            // repainting my frame
            myPaint.repaint();
        }
    }

    // painting
    class DrawingMoment extends JPanel {

        public void paint(Graphics g) {
            super.paint(g);
            Graphics2D g2d = (Graphics2D) g;
            if (myPoints != null) {
                // get frame size
                double frameSizeX = myPaint.getSize().width * 0.88;
                double frameSizeY = myPaint.getSize().height * 0.88;

                // print info
                //System.out.print("(" + frameSizeX + ", ");
                //System.out.println(frameSizeY + ")");

                // bery hard algoruthm //
                // roflan pominki

                double multiDudeX = (frameSizeX / 8) * 1.1;
                double multiDudeY = (frameSizeY / 8) * 1.1;

                //System.out.println(multiDudeX + " " + multiDudeY);

                pointsListX = new ArrayList<>();
                pointsListY = new ArrayList<>();

                double pointX = 0, pointY = 0;
                double multi = 0;
                for (int i = 0; i < myPoints.numberOfPoints; i++) {

                    // cool algo
                    pointX = 1.1 * myPoints.getX(i) * multiDudeX / 7;
                    pointY = 1.06 * frameSizeY - (myPoints.getY(i) * multiDudeY / 7);

                    pointsListX.add((int) pointX);
                    pointsListY.add((int) pointY);

                    // main constr
                    // g2d.drawString(
                    //         "" + (i + 1),
                    //         (int) pointX,
                    //         (int) pointY
                    // );

                    float thick = ((float) multiDudeX + (float) multiDudeY) / 10;
                    g2d.setStroke(new BasicStroke(thick));

                    g2d.drawOval(
                            (int) (pointX * 0.98), (int) (pointY * 0.98),
                            (int) (frameSizeX * 0.03 * 0.9), (int) (frameSizeY * 0.029 * 0.9)
                    );

                    System.out.println((int) (pointX) + " " + (int) (pointY));
                    System.out.println((int) (pointX * 0.99) + " " + (int) (pointY * 0.99));
                }

                //myLines.printAll();
                //System.out.println(myLines.getConnectionF(1) + 1);
                //System.out.println(myLines.getConnectionS(1) + 1);
                //System.out.println(myLines.getThickness(myLines.getConnectionF(1) + 1, myLines.getConnectionS(1) + 1));


                for (int i = 0; i < myLines.getSize(); i++) {
                    float thickness = myLines.getThickness(myLines.getConnectionF(i) + 1, myLines.getConnectionS(i) + 1);
                    thickness = thickness * ((float) ((multiDudeY + multiDudeX) * 0.003));
                    g2d.setStroke(new BasicStroke(thickness));

                    g2d.drawLine(
                            pointsListX.get((myLines.getConnectionF(i))),
                            pointsListY.get((myLines.getConnectionF(i))),
                            pointsListX.get((myLines.getConnectionS(i))),
                            pointsListY.get((myLines.getConnectionS(i)))
                    );
                }

            }

        }

    }


}

class NormalisationThickness {
    private final List<Integer> dataBuffX;

    private int minValX;

    private final List<Double> normX;

    private double rangeOfXVal;


    NormalisationThickness() {
        this.dataBuffX = new ArrayList<>();

        normX = new ArrayList<>();
    }

    void addDataToBuff(int dataX) {
        dataBuffX.add(dataX);
    }

    private void calculateRange() {
        rangeOfXVal = Collections.max(dataBuffX) - Collections.min(dataBuffX);
    }

    void calculateNorm() {
        calculateRange();
        minValX = Collections.min(dataBuffX);

        // https://www.indeed.com/career-advice/career-development/normalization-formula
        // While this normalization formula brings all results into a range between zero and one,
        // there is a variation on the normalization formula to use if you're trying to put all
        // data within a custom range where the lowest value is a and the highest value is b:
        // xnormalized = a + ( ((x - xminimum) * (b - a)) / range of x)

        int min = 3;
        int max = 20;
        double xNorm, yNorm;
        for (Integer buffX : dataBuffX) {
            xNorm = min + (((buffX - minValX) * (max - min)) / rangeOfXVal);
            normX.add(xNorm);
        }
    }

    double getX(int number) {
        return normX.get(number);
    }

    void printAll() {
        System.out.println(normX);
    }

}

class Lines {
    private final Map<ArrayList<Integer>, Integer> listIntegerMap;
    private final ArrayList<ArrayList<Integer>> linesArrayList;
    private ArrayList<Integer> buffer;
    private ArrayList<ArrayList<Integer>> dumbBuffer;

    Lines() {
        this.listIntegerMap = new HashMap<ArrayList<Integer>, Integer>();
        linesArrayList = new ArrayList<>();
        // ful this
        int vertexCount = 2;
        for (int i = 0; i < vertexCount; i++) {
            linesArrayList.add(new ArrayList());
        }
    }

    int getSize() {
        return listIntegerMap.size();
    }

    void linesAdder(int x, int y, int thickness) {
        buffer = new ArrayList<>();
        buffer.add(x);
        buffer.add(y);
        listIntegerMap.put(buffer, thickness);
    }

    int getThickness(int fPoint, int sPoint) {
        buffer = new ArrayList<>();
        buffer.add(fPoint);
        buffer.add(sPoint);
        return listIntegerMap.get(buffer);
    }

    int getConnectionF(int connection) {
        dumbBuffer = new ArrayList<>(listIntegerMap.keySet());
        return dumbBuffer.get(connection).get(0) - 1;
    }

    int getConnectionS(int connection) {
        dumbBuffer = new ArrayList<>(listIntegerMap.keySet());
        return dumbBuffer.get(connection).get(1) - 1;
    }

    void printKey() {
        System.out.println(listIntegerMap.keySet());
    }

    void printAll() {
        listIntegerMap.keySet().stream().map(i -> "key: " + i + " value: " + listIntegerMap.get(i)).forEach(System.out::println);
    }
}

class Normalisation {
    private final List<Integer> dataBuffX;
    private final List<Integer> dataBuffY;

    private int minValX;
    private int minValY;

    private final List<Double> normX;
    private final List<Double> normY;

    private double rangeOfXVal;
    private double rangeOfYVal;


    Normalisation() {
        this.dataBuffX = new ArrayList<>();
        this.dataBuffY = new ArrayList<>();

        normX = new ArrayList<>();
        normY = new ArrayList<>();
    }

    void addDataToBuff(int dataX, int dataY) {
        dataBuffX.add(dataX);
        dataBuffY.add(dataY);
    }

    private void calculateRange() {
        rangeOfXVal = Collections.max(dataBuffX) - Collections.min(dataBuffX);
        rangeOfYVal = Collections.max(dataBuffY) - Collections.min(dataBuffY);
    }

    void calculateNorm() {
        calculateRange();
        minValX = Collections.min(dataBuffX);
        minValY = Collections.min(dataBuffY);

        // https://www.indeed.com/career-advice/career-development/normalization-formula
        // While this normalization formula brings all results into a range between zero and one,
        // there is a variation on the normalization formula to use if you're trying to put all
        // data within a custom range where the lowest value is a and the highest value is b:
        // xnormalized = a + ( ((x - xminimum) * (b - a)) / range of x)

        int min = 1;
        int max = 50;
        double xNorm, yNorm;
        for (int i = 0; i < dataBuffX.size(); i++) {
            xNorm = min + (((dataBuffX.get(i) - minValX) * (max - min)) / rangeOfXVal);
            normX.add(xNorm);

            yNorm = min + (((dataBuffY.get(i) - minValY) * (max - min)) / rangeOfYVal);
            normY.add(yNorm);
        }
    }

    double getX(int number) {
        return normX.get(number);
    }

    double getY(int number) {
        return normY.get(number);
    }

    void printAll() {
        System.out.println(normX);
        System.out.println(normY);
    }


}

class Points {
    private final ArrayList<ArrayList<Double>> points;
    int numberOfPoints;

    Points(int numberOfPoints) {
        this.numberOfPoints = numberOfPoints;
        int vertexCount = 2;
        points = new ArrayList<>(vertexCount);
        for (int i = 0; i < vertexCount; i++) {
            points.add(new ArrayList());
        }
        //System.out.println("Array list have been created!!");
    }


    double getX(int number) {
        return points.get(0).get(number);
    }

    double getY(int number) {
        return points.get(1).get(number);
    }

    void setPoints(double x, double y) {
        points.get(0).add(x);
        points.get(1).add(y);
    }

    void printAllData() {
        System.out.println(points.get(0));
        System.out.println(points.get(1));
    }
}