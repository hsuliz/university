import java.util.List;

/**
 * Interfejs ogÃ³lnego systemu pozwalajÄ…cego wyznaczaÄ‡ stany licznikÃ³w
 * zagnieÅ¼dÅ¼onych pÄ™tli typu for.
 */
public interface GeneralLoops {
    /**
     * Metoda ustalajÄ…ca dolne limity pÄ™tli. Metoda wywoÅ‚ywana opcjonalnie. JeÅ›li
     * metody nie wywoÅ‚ano pÄ™tle rozpoczynajÄ… iteracje od 0. Limit na pozycji 0
     * odpowiada pÄ™tli zewnÄ™trznej. Ostatni - najbardziej zagnieÅ¼dzonej pÄ™tli
     * wewnÄ™trznej.
     *
     * @param limits lista wartoÅ›ci, od ktÃ³rych rozpoczynane sÄ… iteracje w kolejnych
     *               pÄ™tlach.
     */
    public void setLowerLimits(List<Integer> limits);

    /**
     * Metoda ustalajÄ…ca gÃ³rny limit pÄ™tli. Metoda wywoÅ‚ywana opcjonalnie. JeÅ›li
     * metody nie wywoÅ‚ano gÃ³rnym limitem pÄ™tli jest 0. Limit na pozycji 0
     * odpowiada pÄ™tli zewnÄ™trznej. Ostatni - najbardziej zagnieÅ¼dzonej pÄ™tli
     * wewnÄ™trznej.
     *
     * @param limits lista wartoÅ›ci, na ktÃ³rych koÅ„czy siÄ™ wykonywanie iteracji w
     *               kolejnych pÄ™tlach.
     */
    public void setUpperLimits(List<Integer> limits);

    /**
     * Metoda zwraca listÄ™ list stanÃ³w pÄ™tli - zewnÄ™trzna lista to kolejne iteracje,
     * wewnÄ™trzna stan licznikÃ³w w danej iteracji. Np. przy limitach wynoszÄ…cych
     * {0,0,1} i {1,2,2} wynikiem powinno byÄ‡:
     *
     * <pre>
     * {0,0,1},
     * {0,0,2},
     * {0,1,1},
     * {0,1,2},
     * {0,2,1},
     * {0,2,2},
     * {1,0,1},
     * {1,0,2},
     * {1,1,1},
     * {1,1,2},
     * {1,2,1},
     * {1,2,2}
     * </pre>
     *
     * czyli 12 (2x3x2) list o rozmiarze 3. KolejnoÅ›Ä‡ danych ma znaczenie i
     * odpowiada dziaÅ‚aniu zagnieÅ¼dÅ¼onych pÄ™tli for.
     *
     * @return lista zawierajÄ…ca listy stanÃ³w licznikÃ³w poszczegÃ³lnych pÄ™tli.
     */
    public List<List<Integer>> getResult();
}