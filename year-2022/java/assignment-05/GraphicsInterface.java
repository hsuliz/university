/**
 * Interfejs narzÄ™dzia graficznego.
 *
 */
public interface GraphicsInterface {

    /**
     * WyjÄ…tek zgÅ‚aszany w przypadku braku dostÄ™pu do pÅ‚Ã³tna.
     */
    public class NoCanvasException extends Exception {
        private static final long serialVersionUID = 8263666547167500356L;
    }

    /**
     * WyjÄ…tek zgÅ‚aszany, gdy poczÄ…tkowe poÅ‚oÅ¼enie, od ktÃ³rego wypeÅ‚niany jest
     * obszar jest nieprawidÅ‚owe (poza obszarem pÅ‚Ã³tna) lub powodujÄ…ce zgÅ‚oszenie
     * wyjÄ…tku {@link CanvasInterface.BorderColorException}.
     *
     */
    public class WrongStartingPosition extends Exception {
        private static final long serialVersionUID = -8582620817646059440L;
    }

    /**
     * Metoda, za pomocÄ… ktÃ³rej uÅ¼ytkownik dostarcza pÅ‚Ã³tno, na ktÃ³rym wykonywane
     * bÄ™dÄ… operacje graficzne.
     *
     * @param canvas referencja do pÅ‚Ã³tna
     */
    public void setCanvas(CanvasInterface canvas);

    /**
     * Metoda wypeÅ‚niajÄ…ca obszar kolorem color. WypeÅ‚nianie obszaru rozpoczynane
     * jest od pozycji startingPosition.
     *
     * @param startingPosition poÅ‚oÅ¼enie poczÄ…tkowe
     * @param color            kolor, ktÃ³rym wypeÅ‚niany jest obszar
     * @throws WrongStartingPosition poÅ‚oÅ¼enie poczÄ…tkowe jest niepoprawne
     * @throws NoCanvasException     referencja do pÅ‚Ã³tna jest niepoprawna
     */
    public void fillWithColor(Position startingPosition, Color color) throws WrongStartingPosition, NoCanvasException;
}