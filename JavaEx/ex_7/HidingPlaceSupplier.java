/**
 * Dostawca skrytek
 *
 */
public interface HidingPlaceSupplier {
    /**
     * Interfejs pojedynczej skrytki
     *
     */
    public interface HidingPlace {
        /**
         * Zwraca true jeÅ›li skrytka coÅ› zawiera. W przeciwnym wypadku false.
         *
         * @return czy skrytka posiada zawartoÅ›Ä‡
         */
        public boolean isPresent();

        /**
         * Otwiera skrytkÄ™ i zwraca jej wartoÅ›Ä‡.
         *
         * @return wartoÅ›Ä‡ zawartoÅ›ci skrytki
         */
        public double openAndGetValue();
    }

    /**
     * Zwraca pojedynczÄ… skrytkÄ™, brak skrytek sygnalizuje za pomocÄ… null. Metoda
     * moÅ¼e byÄ‡ wykonywana wspÃ³Å‚bieÅ¼nie.
     *
     * @return obiekt skrytki
     */
    public HidingPlace get();

    /**
     * Liczba wÄ…tkÃ³w, ktÃ³re majÄ… obsÅ‚ugiwaÄ‡ przeszukiwanie skrytek.
     * WartoÅ›Ä‡ jest staÅ‚a dla danego obiektu.
     *
     * @return liczba wÄ…tkÃ³w jakie majÄ… przeszukiwaÄ‡ skrytki
     */
    public int threads();
}