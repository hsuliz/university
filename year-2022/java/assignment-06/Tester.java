public class Tester {
    public static void main(String[] args) {
        Compression d = new Compression();
        //String[] nig = {"00", "01", "10", "11"};
        String[] nig = {"001", "001", "001", "010", "111", "011", "001", "001", "110", "000", "001", "001", "001", "001"};

        for (String s : nig) {
            d.addWord(s);
        }
        d.compress();
        System.out.println(d.getWord());

    }
}
