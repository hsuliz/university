
/**
 * Interfejs dostawcy obiektÃ³w zgodnych z HidingPlaceSupplier
 */
public interface HidingPlaceSupplierSupplier {
    /**
     * Metoda zwraca obiekty dostarczajÄ…ce skrytek aÅ¼ do wyczerpania ich liczby.
     * Brak kolejnych obiektÃ³w sygnalizowane jest poprzez zwrÃ³cenie null.
     *
     * @param totalValueOfPreviousObject suma wartoÅ›ci przedmiotÃ³w w wyciÄ…gniÄ™tych
     *                                   ze skrytek dostrczonych przez poprzedni
     *                                   obiekt HidingPlaceSupplier.
     * @return obiekt dostarcy skrytek
     */
    public HidingPlaceSupplier get(double totalValueOfPreviousObject);
}