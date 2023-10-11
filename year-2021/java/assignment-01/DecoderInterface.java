
/**
 * Abstrakcyjna klasa definiujÄ…ca interfejs pozwalajÄ…cy na dekodowanie protokoÅ‚u
 * szeregowego opisanego w zadaniu 01.
 *
 * @author oramus
 *
 */
public abstract class DecoderInterface {
    /**
     * Metoda pozwala na dostarczanie danych do zdekodowania. Pojedyncze wywoÅ‚anie
     * metody dostarcza jeden bit.
     *
     * @param bit Argumentem wywoÅ‚ania jest dekodowany bit. Argument moÅ¼e przybraÄ‡
     *            wartoÅ›ci wyÅ‚Ä…cznie 0 i 1.
     */
    public abstract void input(int bit);

    /**
     * Metoda zwraca odkodowane dane. Metoda nigdy nie zwraca null. JeÅ›li jeszcze
     * Å¼adna liczba nie zostaÅ‚a odkodowana metoda zwraca "" (pusty ciÄ…g znakÃ³w,
     * czyli ciÄ…g znakÃ³w o dÅ‚ugoÅ›ci rÃ³wnej 0).
     *
     * @return CiÄ…g znakÃ³w reprezentujÄ…cy sekwencjÄ™ odkodowanych danych.
     */
    public abstract String output();

    /**
     * Metoda przywraca stan poczÄ…tkowy. Proces odkodowywania danych zaczyna siÄ™ od
     * poczÄ…tku.
     */
    public abstract void reset();
}