/**
 * Typ wyliczeniowy reprezentujÄ…cy kolory
 */
public enum Color {
    BLACK, WHITE, GREEN, YELLOW, RED, ORANGE, PINK,
    ;

    /**
     * Metoda main pozwalajÄ…ca zobaczyÄ‡ jak prezentowane sÄ…
     * poszczegÃ³lne kolory.
     */
    public static void main(String[] args) {
        for (Color color : Color.values()) {
            System.out.println(color.name() + " -> " + color);
        }
    }

    @Override
    public String toString() {
        return name().substring(0, 1);
    }
}