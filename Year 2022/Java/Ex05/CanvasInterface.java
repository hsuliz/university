/**
 * Interfejs pÅ‚Ã³tna
 */
public interface CanvasInterface {

    /**
     * Metoda pozwalajÄ…ca na zmianÄ™ koloru piksela o poÅ‚oÅ¼eniu position na color.
     *
     * @param position poÅ‚oÅ¼enie piksela
     * @param color    nowy kolor piksela
     * @throws CanvasBorderException poÅ‚oÅ¼enie wypada poza obszarem pÅ‚Ã³tna
     * @throws BorderColorException  zmieniono kolor piksela granicznego
     */
    public void setColor(Position position, Color color) throws CanvasBorderException, BorderColorException;

    /**
     * WyjÄ…tek zgÅ‚aszany, gdy zlecana jest operacja poza obszarem pÅ‚Ã³tna.
     */
    public class CanvasBorderException extends Exception {
        private static final long serialVersionUID = 4759606029757073905L;
    }

    /**
     * WyjÄ…tek zgÅ‚aszany, gdy piksel zmienia kolor ze stanowiÄ…cego kolor graniczny
     * na nowy kolor.
     */
    public class BorderColorException extends Exception {
        private static final long serialVersionUID = -4752159948902473254L;
        public final Color previousColor;

        public BorderColorException(Color color) {
            previousColor = color;
        }
    }
}