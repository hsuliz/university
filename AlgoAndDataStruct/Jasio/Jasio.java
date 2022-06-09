
/**
 *
 * Scieżke do plików testujących można zmienic w metodie main, 30 linijka.
 *
 */

import java.io.File;
import java.util.*;

public class Jasio {
    static public Map<Integer, Set<Integer>> sameElements = new HashMap<>();
    static Set<Integer> preFinal = new HashSet<>();
    int V;
    LinkedList<Integer>[] adj;
    int counter = 1;

    Jasio(int V) {
        this.V = V;
        adj = new LinkedList[V];

        for (int i = 0; i < adj.length; i++) {
            adj[i] = new LinkedList<>();
        }

    }

    public static void main(String[] args) {
        ////////////////
        // file path //
        String pathName = "";
        File file = new File(pathName);

        //////////////////////////////////

        Jasio g = null;
        int totalSize = 0;

        try (Scanner scanner = new Scanner(file)) {
            int counter = 0;
            while (scanner.hasNext()) {
                if (counter == 0) {
                    totalSize = scanner.nextInt();
                    g = new Jasio(totalSize);
                } else {
                    g.addEdge(scanner.nextInt() - 1, counter - 1);
                }
                counter++;
            }
        } catch (Exception e) {
            throw new RuntimeException("File problem");
        }

        for (int i = 0; i < totalSize; i++) {
            g.DFS(i);
        }

        Map<Integer, List<Integer>> sameMap = new HashMap<>();

        for (int i = 1; i <= sameElements.size(); i++) {

            List<Integer> tmpSet = new ArrayList<>();

            for (int j = i + 1; j <= sameElements.size() + 1; j++) {
                if (sameElements.get(i).equals(sameElements.get(j))) {
                    // System.out.println(i + " is equals with " + j);
                    tmpSet.add(j);
                } else if (j == sameElements.size() + 1) {
                    sameMap.put(i, tmpSet);
                }
            }

        }

        // System.out.println(sameMap);
        List<Integer> moreVal = new ArrayList<>();

        for (int i = 1; i <= sameMap.size(); i++) {

            for (int j = 0; j < sameMap.get(i).size(); j++) {
                if (!sameMap.get(i).isEmpty()) {
                    moreVal.add(sameMap.get(i).get(j));
                }
            }

        }

        // System.out.println(moreVal);

        // delete duplicates
        Set<Integer> finalSet = new HashSet<>(moreVal);
        finalSet.addAll(preFinal);
        List<Integer> duplicates = new ArrayList<>();

        for (int i = 0; i < moreVal.size(); i++) {

            for (int j = i + 1; j < moreVal.size(); j++) {
                if (Objects.equals(moreVal.get(i), moreVal.get(j))) {
                    duplicates.add(moreVal.get(i));
                }
            }

        }
        // System.out.println(duplicates);

        for (int i = 0; i < duplicates.size(); i++) {
            finalSet.remove(duplicates.get(i));
        }

        System.out.println("Need to break: " + finalSet.size());
        System.out.println(finalSet);
    }

    void addEdge(int v, int w) {
        // System.out.println(v + " " + (w));
        if (v == w) {
            preFinal.add(v + 1);
        }
        adj[v].add(w);
    }

    void DFS(int n) {
        boolean[] nodes = new boolean[V];

        Stack<Integer> stack = new Stack<>();
        Set<Integer> set = new HashSet<>();

        stack.push(n);
        int a;

        while (!stack.empty()) {
            n = stack.peek();
            stack.pop();

            if (!nodes[n]) {
                // System.out.print(n + 1 + " ");
                set.add(n + 1);
                nodes[n] = true;
            }

            for (int i = 0; i < adj[n].size(); i++) {
                a = adj[n].get(i);
                if (!nodes[a]) {
                    stack.push(a);
                }
            }
        }

        sameElements.put(counter, set);
        counter++;
    }
}
