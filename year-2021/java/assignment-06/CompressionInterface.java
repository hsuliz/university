import java.util.Map;

public interface CompressionInterface {
    /**
     * Metoda dodaje pojedyncze sÅ‚owo. Wszystkie sÅ‚owa bÄ™dÄ… mieÄ‡ takÄ… samÄ… dÅ‚ugoÅ›Ä‡ i
     * skÅ‚adaÄ‡ siÄ™ wyÅ‚Ä…cznie z kombinacji zer i jedynek.
     *
     * @param word sÅ‚owo z ciÄ…gu danych przeznaczonych do kompresji.
     */
    public void addWord(String word);

    /**
     * Metoda zleca wykonanie kompresji przekazanych danych.
     */
    public void compress();

    /**
     * Metoda zwraca nagÅ‚Ã³wek. Mapa zawiera jako klucz ciÄ…g, ktÃ³ry koduje sÅ‚owo i
     * sÅ‚owo, ktÃ³re jest nim kodowane. W nagÅ‚Ã³wku umieszczane sÄ… wyÅ‚Ä…cznie
     * informacje o sÅ‚owach, ktÃ³re kodowane bÄ™dÄ… za pomocÄ… mniejszej niÅ¼ oryginalna
     * iloÅ›ci bitÃ³w. JeÅ›li przekazanej sekwencji nie moÅ¼na skompresowaÄ‡ podanÄ…
     * metodÄ… metoda zwraca mapÄ™ o rozmiarze 0.
     *
     * @return mapa kodowania sÅ‚Ã³w
     */
    public Map<String, String> getHeader();

    /**
     * Metoda zwraca kolejne elementy skompresowanej sekwencji.
     *
     * @return pojedyncze sÅ‚owo ze skompresowanej sekwencji.
     */
    public String getWord();

}