import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

class Decrypter implements DecrypterInterface {
    String wfais = "WydziałFizykiAstronomiiiInformatykiStosowanej";
    ArrayList<Integer> bruh = new ArrayList<>();
    private Map<Character, Character> code;
    private Map<Character, Character> decode;
    private String clearInPut;
    private int onWhatString = 0;
    private boolean nullDude = true;
    // przepraszam za taki kod....
    private void finder(int idkWhyImDoingThis) {
        int tmp = 0;
        for (int i = 0; i < clearInPut.length(); i++) {
            if (clearInPut.charAt(i) == ' ') {
                bruh.add(i - tmp - 1);
                tmp = i;
            }
        }
        for (int i = idkWhyImDoingThis; i < bruh.size() - 5; i++) {
            // bruh..
            if (bruh.get(i).equals(7)) {
                if (bruh.get(i + 1).equals(7))
                    if (bruh.get(i + 2).equals(10))
                        if (bruh.get(i + 3).equals(1))
                            if (bruh.get(i + 4).equals(11))
                                if (bruh.get(i + 5).equals(10)) {
                                    System.out.println("Founed!1");
                                    onWhatString = i;
                                    break;
                                }

            }
        }
    }

    public void setInputText(String encryptedDocument) {
        if (encryptedDocument == null) {
            code = new HashMap<>();
            decode = new HashMap<>();
            return;
        }
        // roflanPominki
        encryptedDocument += "\nt\t";
        String why = "\td\t";
        why += encryptedDocument;
        encryptedDocument = why;
        // junk cleaner
        clearInPut = encryptedDocument.trim().replaceAll("[\\t\\n\\r\\f\\s]", " ");
        clearInPut = clearInPut.replaceAll("[ ]+", " ");
        int da = 1;
        while (true) {
            finder(da++);
            String fullClearInPut = clearInPut.replaceAll("\\s", "");
            System.out.println();
            int stringCounter = 1;
            code = new HashMap<>();
            decode = new HashMap<>();

            //System.out.println(onWhatString);
            for (int i = 0; i < onWhatString; i++) {
                stringCounter += bruh.get(i);
            }
            //System.out.println("=====");
            int wfaisDelta = wfais.length() + stringCounter;
            //works...........
            boolean commaKiller = true;
            int commaDude = 0;
            int falser = 0;
            for (int i = stringCounter, j = 0; i <= wfaisDelta; i++, j++) {
                if (i == fullClearInPut.length()) {
                    code = new HashMap<>();
                    decode = new HashMap<>();
                    return;
                }
                if (fullClearInPut.charAt(i) == ',') {
                    commaDude++;
                    if (commaKiller) {
                        j--;
                        commaKiller = false;
                        continue;
                    }
                }
                if (code.containsKey(fullClearInPut.charAt(i))) {
                    if (code.get(fullClearInPut.charAt(i)) != wfais.charAt(j)) {
                        falser++;
                    }
                }
                code.put(fullClearInPut.charAt(i), wfais.charAt(j));
                decode.put(wfais.charAt(j), fullClearInPut.charAt(i));
            }
            if (commaDude > 1 || falser != 0) {
                continue;
            }
            System.out.println();
            System.out.println(falser);
            break;
        }
        nullDude = false;
    }
    public Map<Character, Character> getDecode() {
        if(nullDude) {
            code = new HashMap<>();
        }
        return code;
    }
    public Map<Character, Character> getCode() {
        if(nullDude) {
            decode = new HashMap<>();
        }
        return decode;
    }
}