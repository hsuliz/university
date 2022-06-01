import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MazeGenerator extends Canvas {
    private static final Random rand = new Random();
    private static final int WIDTH = 60;
    private static final int HEIGHT = 60;
    private static final int TILE_WIDTH = 10;
    private static final int TILE_HEIGHT = 10;

    private final List<Cell> maze = new ArrayList<>();

    public static void main(String[] args) {
        MazeGenerator mazeGenerator = new MazeGenerator();
        mazeGenerator.generate();
        mazeGenerator.setSize(600, 600);
        JFrame frame = new JFrame("Prims maze generator");
        frame.add(mazeGenerator);
        frame.setSize(600, 630);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);

        g.drawLine(0, 0, 0, HEIGHT * TILE_HEIGHT);
        g.drawLine(0, 0, WIDTH * TILE_WIDTH, 0);
        g.drawLine(WIDTH * TILE_WIDTH, 0, WIDTH * TILE_WIDTH, HEIGHT * TILE_HEIGHT);
        g.drawLine(0, HEIGHT * TILE_HEIGHT, WIDTH * TILE_WIDTH, HEIGHT * TILE_HEIGHT);

        List<Cell> mazeList = maze;

        // Prims algo here
        for (int y = 0; y < HEIGHT; y++) {
            for (int x = 0; x < WIDTH; x++) {
                int current = (y * WIDTH) + x;
                int lower = ((y + 1) * WIDTH) + x;
                if (!mazeList.contains(new Cell(current, lower))) {
                    g.drawLine(x * TILE_WIDTH, (y + 1) * TILE_HEIGHT, (x + 1) * TILE_WIDTH, (y + 1) * TILE_HEIGHT);
                }

                if (!mazeList.contains(new Cell(current, current + 1))) {
                    g.drawLine((x + 1) * TILE_WIDTH, y * TILE_HEIGHT, (x + 1) * TILE_WIDTH, (y + 1) * TILE_HEIGHT);
                }

            }
        }
    }

    public void generate() {
        List<Integer> visited = new ArrayList<>();
        List<Cell> toVisit = new ArrayList<>();

        visited.add(0);
        toVisit.add(new Cell(0, 1));
        toVisit.add(new Cell(0, WIDTH));

        while (toVisit.size() > 0) {
            int randomIndex = rand.nextInt(toVisit.size());
            Cell nextPath = toVisit.remove(randomIndex);

            if (visited.contains(nextPath.end)) {
                continue;
            }

            if (nextPath.start > nextPath.end) {
                maze.add(new Cell(nextPath.end, nextPath.start));
            } else {
                maze.add(nextPath);
            }

            visited.add(nextPath.end);

            int above = nextPath.end - WIDTH;
            if (above > 0 && !visited.contains(above)) {
                toVisit.add(new Cell(nextPath.end, above));
            }

            int left = nextPath.end - 1;
            if (left % WIDTH != WIDTH - 1 && !visited.contains(left)) {
                toVisit.add(new Cell(nextPath.end, left));
            }

            int right = nextPath.end + 1;
            if (right % WIDTH != 0 && !visited.contains(right)) {
                toVisit.add(new Cell(nextPath.end, right));
            }

            int below = nextPath.end + WIDTH;
            if (below < WIDTH * HEIGHT && !visited.contains(below)) {
                toVisit.add(new Cell(nextPath.end, below));
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