import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MazeGenerator extends Canvas {

    // set up for painting
    private static final Random rand = new Random();
    // length of cell
    private static final int frameWidthX = 50;
    private static final int frameHeightY = 50;
    // size of cells
    private static final int frameWidthXSize = 10;
    private static final int frameHeightXSize = 10;
    final int margins = 60;
    private final List<Cell> maze = new ArrayList<>();

    public static void main(String[] args) {
        MazeGenerator mazeGenerator = new MazeGenerator();
        mazeGenerator.primsAlgorithm(); // algo generator
        mazeGenerator.setSize(600, 600);
        JFrame frame = new JFrame("Prims maze generator");
        frame.add(mazeGenerator);
        frame.setSize(700, 700);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);


        g.drawLine(margins, margins, margins, frameHeightY * frameHeightXSize + margins);
        g.drawLine(margins, margins, frameWidthX * frameWidthXSize + margins, margins);
        g.drawLine(frameWidthX * frameWidthXSize + margins, margins, frameWidthX * frameWidthXSize + margins, frameHeightY * frameHeightXSize + margins);
        g.drawLine(margins, frameHeightY * frameHeightXSize + margins, frameWidthX * frameWidthXSize + margins, frameHeightY * frameHeightXSize + margins);

        List<Cell> mazeList = maze;

        // simple drawing
        for (int y = 0; y < frameHeightY; y++) {
            for (int x = 0; x < frameWidthX; x++) {

                int current = (y * frameWidthX) + x;
                int lower = ((y + 1) * frameWidthX) + x;

                if (!mazeList.contains(new Cell(current, lower))) {
                    g.drawLine(x * frameWidthXSize + margins, (y + 1) * frameHeightXSize + margins, (x + 1) * frameWidthXSize + margins, (y + 1) * frameHeightXSize + margins);
                }
                if (!mazeList.contains(new Cell(current, current + 1))) {
                    g.drawLine((x + 1) * frameWidthXSize + margins, y * frameHeightXSize + margins, (x + 1) * frameWidthXSize + margins, (y + 1) * frameHeightXSize + margins);
                }
            }
        }
    }

    public void primsAlgorithm() {
        List<Integer> visited = new ArrayList<>();
        List<Cell> toVisit = new ArrayList<>();

        visited.add(0);
        toVisit.add(new Cell(0, 1));
        toVisit.add(new Cell(0, frameWidthX));

        while (toVisit.size() > 0) {
            int randomIndex = rand.nextInt(toVisit.size());
            Cell next = toVisit.remove(randomIndex);

            if (visited.contains(next.end)) {
                continue;
            }

            if (next.start > next.end) {
                maze.add(new Cell(next.end, next.start));
            } else {
                maze.add(next);
            }

            visited.add(next.end);

            int above = next.end - frameWidthX;
            if (above > 0 && !visited.contains(above)) {
                toVisit.add(new Cell(next.end, above));
            }

            int left = next.end - 1;
            if (left % frameWidthX != frameWidthX - 1 && !visited.contains(left)) {
                toVisit.add(new Cell(next.end, left));
            }

            int right = next.end + 1;
            if (right % frameWidthX != 0 && !visited.contains(right)) {
                toVisit.add(new Cell(next.end, right));
            }

            int below = next.end + frameWidthX;
            if (below < frameWidthX * frameHeightY && !visited.contains(below)) {
                toVisit.add(new Cell(next.end, below));
            }
        }
    }
}

class Cell {
    public int start;
    public int end;

    public Cell(int start, int end) {
        this.start = start;
        this.end = end;
    }

    @Override
    public boolean equals(Object obj) {
        if (!(obj instanceof Cell cell)) {
            return false;
        }
        return cell.start == start && cell.end == end;
    }
}