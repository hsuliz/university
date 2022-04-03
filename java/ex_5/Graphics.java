import java.util.ArrayList;
import java.util.List;

class Graphics implements GraphicsInterface {

    CanvasInterface canvas;
    List<Position> positionArrayList, curPosArrayList;
    Position basedPos;

    public void fillWithColor(Position startingPosition, Color color)
            throws GraphicsInterface.WrongStartingPosition, GraphicsInterface.NoCanvasException {

        // no canvas
        if (canvas == null) {
            System.out.println("NO CANVAS!!");
            throw new NoCanvasException();
        }

        // default
        try {
            canvas.setColor(startingPosition, color);
        } catch (CanvasInterface.CanvasBorderException e) {
            System.out.println("Wrong Starting Position!!");
            throw new WrongStartingPosition();
        } catch (CanvasInterface.BorderColorException e) {
            try {
                canvas.setColor(startingPosition, e.previousColor);
            } catch (CanvasInterface.BorderColorException | CanvasInterface.CanvasBorderException ex) {
                // useless
                System.out.println("ACYHASVCEFCHBECFEFBCESJFCBJES");
            }
            System.out.println("Wrong Starting Position!!");
            throw new WrongStartingPosition();
        }

        mainAlgo(startingPosition, color);

        System.out.println("IM DONE!!");
    }

    private void mainAlgo(Position startingPosition, Color color) {
        positionArrayList = new ArrayList<>();
        curPosArrayList = new ArrayList<>();
        positionArrayList.add(startingPosition);

        for (int i = 0; i < positionArrayList.size(); i++) {

            // adding to array
            basedPos = positionArrayList.get(i);
            System.out.println("ADDING COUNTER " + i);
            if (curPosArrayList.contains(basedPos)) {
                System.out.println("\tCope");
                continue;
            } else {
                System.out.println("\tAdding");
                curPosArrayList.add(basedPos);
            }

            // MAIN
            System.out.println("MAIN NUMBER " + i);
            try {
                canvas.setColor(basedPos, color);
            } catch (CanvasInterface.CanvasBorderException e) {
                System.out.println("\tCanvas Border Exception!!");
                continue;
            } catch (CanvasInterface.BorderColorException e) {
                try {
                    System.out.println("\tTry set color");
                    canvas.setColor(basedPos, e.previousColor);
                    continue;
                } catch (CanvasInterface.BorderColorException | CanvasInterface.CanvasBorderException ex) {
                    // useless
                    System.out.println("ACYHASVCEFCHBECFEFBCESJFCBJES");
                }
            }

            /*
            [ col + 1, row ]
            [ col - 1, row ]
            [ col, row - 1 ]
            [ col, row + 1 ]
            */

            // reuse
            positionArrayList.add(new Position2D(basedPos.getCol() + 1, basedPos.getRow()));
            positionArrayList.add(new Position2D(basedPos.getCol() - 1, basedPos.getRow()));
            positionArrayList.add(new Position2D(basedPos.getCol(), basedPos.getRow() - 1));
            positionArrayList.add(new Position2D(basedPos.getCol(), basedPos.getRow() + 1));
        }
    }

    public void setCanvas(CanvasInterface canvas) {
        this.canvas = canvas;
    }

    // snake copy
    class Position2D implements Position {

        private final int col;
        private final int row;

        public Position2D(int col, int row) {
            this.col = col;
            this.row = row;
        }

        public int getRow() {
            return row;
        }

        public int getCol() {
            return col;
        }

        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (obj == null) return false;
            if (getClass() != obj.getClass()) return false;
            Position2D other = (Position2D) obj;
            return col == other.col && row == other.row;
        }

    }

}