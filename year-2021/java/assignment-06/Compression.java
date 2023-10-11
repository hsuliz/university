import java.util.*;
import java.util.stream.Collectors;

public class Compression implements CompressionInterface {
    List<String> wordStorage = new ArrayList<>();
    List<String> compressedWordStorage = new ArrayList<>();
    Map<String, String> header = new HashMap<>();
    @Override
    public void addWord(String word) {
        wordStorage.add(word);
    }

    private int logarithm(int number, int base) {
        return (int) (Math.log(number) / Math.log(base));
    }

    @Override
    public void compress() {
        // data set-up
        int numberOfBites = wordStorage.get(0).length();
        int sizeOfInput = wordStorage.size();
        int currentDifference;
        int bestDifference = 0;
        int bitesForCompression = 0;
        List<String> stringListForCompression = null;

        // print info
        System.out.println("Number of bites: " + numberOfBites);

        // stat map
        Map<String, Long> countMap =
                wordStorage.stream().collect(Collectors.groupingBy(e -> e, Collectors.counting()));

        // sorting keys
        List<String> stringList = countMap.entrySet()
                .stream()
                .sorted(Comparator.comparing(Map.Entry<String,Long>::getValue).reversed())
                .map(Map.Entry<String,Long>::getKey)
                .collect(Collectors.toList());


        List<Long> numberList = countMap.entrySet()
                .stream()
                .sorted(Comparator.comparing(Map.Entry<String,Long>::getValue).reversed())
                .map(Map.Entry<String,Long>::getValue)
                .collect(Collectors.toList());

        int differentWords = stringList.size();
        int maxBitesPossible = logarithm(differentWords, 2);

        //System.out.println(stringList);
        //System.out.println(numberList);
        //System.out.println("Max bites possible: " + maxBitesPossible);


        for (int bites = 0; bites <= maxBitesPossible; bites++) {
            int wordsForBites = (int)Math.pow(2, bites);
            int wordsPossible = Math.min(differentWords, wordsForBites);
            for (int words = 1; words <= wordsPossible; words++) {
                List<String> smallStringList = stringList.subList(0, words);
                List<Long> smallNumberList = numberList.subList(0, words);
                currentDifference = sizeOfInput; // 1 / 0  at start of every word
                for (int i = 0; i < words; i++) {
                    int number = smallNumberList.get(i).intValue();
                    currentDifference = currentDifference
                            + (numberOfBites + bites + 1) // header +
                            + (number * bites) // new size +
                            - (number * numberOfBites); // old size -
                    if (currentDifference < bestDifference) {
                        bestDifference = currentDifference;
                        stringListForCompression = smallStringList;
                        bitesForCompression = bites;
                    }
                }
            }
        }

        if (stringListForCompression == null) return;

        Map<String, String> reverseHeader = new HashMap<>();
        for (int i = 0; i < stringListForCompression.size(); ++i) {
            String string = stringListForCompression.get(i);
            String compressedString;
            if (bitesForCompression > 0) {
                StringBuilder compressedStringBuilder = new StringBuilder(Integer.toBinaryString(i));
                while (compressedStringBuilder.length() != bitesForCompression) {
                    compressedStringBuilder.insert(0, "0");
                }
                compressedString = compressedStringBuilder.toString();
            } else {
                compressedString = "";
            }
            reverseHeader.put(string, "0" + compressedString);
            header.put("0" + compressedString, string);
        }

        for (String string : wordStorage) {
            String resultString;
            if (reverseHeader.containsKey(string)) {
                resultString = reverseHeader.get(string);
            } else {
                resultString = "1" + string;
            }
            compressedWordStorage.add(resultString);
        }
    }

    @Override
    public Map<String, String> getHeader() {
        return header;
    }

    @Override
    public String getWord() {
        String word;
        if (compressedWordStorage.isEmpty()) {
            word = null;
        } else {
            word = compressedWordStorage.remove(0);
        }
        return word;
    }
}
