import java.util.Map;

/**
 * Interfejs systemu dekodujÄ…cego zaszyfrowane wiadomoÅ›ci.
 */
public interface DecrypterInterface {
    /**
     * Metoda do przekazania tekstu zakodowanej wiadomoÅ›ci.
     *
     * @param encryptedDocument zaszyfrowana wiadomoÅ›Ä‡.
     */
    public void setInputText(String encryptedDocument);

    /**
     * Metoda zwraca mapÄ™ ujawniajÄ…cÄ… sposÃ³b kodowania. Kluczem tej mapy jest
     * kodowany znak. WartoÅ›ciÄ… znak, na ktÃ³ry klucz zostaÅ‚ zamieniony w
     * zaszyfrowanej wiadomoÅ›ci.
     *
     * @return SposÃ³b zakodowania wiadomoÅ›ci czyli mapa prowadzÄ…ca od znaku do jego
     * kodu. W przypadku braku moÅ¼liwoÅ›ci rozkodowania wiadomoÅ›ci lub jej
     * braku (do setInputText przekazano null, lub metody nie wywoÅ‚ano)
     * zwracana jest mapa o rozmiarze 0.
     */
    public Map<Character, Character> getCode();

    /**
     * Metoda zwraca mapÄ™ ujawniajÄ…cÄ… sposÃ³b moÅ¼liwiajÄ…cy zdekowanie
     * zaszyfrowanej wiadomoÅ›ci Kluczem tej mapy jest kod. WartoÅ›ciÄ… znak, na ktÃ³ry
     * klucz naleÅ¼y zamieniÄ‡ aby odtworzyÄ‡ oryginalnÄ… wiadomoÅ›Ä‡.
     *
     * @return SposÃ³b zdekodowania wiadomoÅ›ci czyli mapa prowadzÄ…ca od kodu do
     * oryginalnego znaku. W przypadku braku moÅ¼liwoÅ›ci rozkodowania
     * wiadomoÅ›ci lub jej braku (do setInputText przekazano null, lub metody
     * nie wywoÅ‚ano) zwracana jest mapa o rozmiarze 0.
     */
    public Map<Character, Character> getDecode();
}