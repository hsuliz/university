public class Main {
    public static void main(String[] args) {
        Decoder ref = new Decoder();
        int[] test1 = {0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0};
        int[] test2 = {1, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0};
        int[] test3 = {0};
        for (int j : test1) {
            ref.input(j);
        }
        System.out.println(ref.output());
        ref.reset();
        for (int j : test2) {
            ref.input(j);
        }
        System.out.println(ref.output());
        ref.reset();
        for (int j : test3) {
            ref.input(j);
        }
        System.out.println(ref.output());
    }
}