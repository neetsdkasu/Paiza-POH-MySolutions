import java.util.*;

public class Main {
    public static void main(String[] args) {
        Scanner q = new Scanner(System.in);
        int n = q.nextInt();
        Map<String, Integer> w = new HashMap<>();
        for (; n > 0; n--) {
            String k = q.next();
            if (w.containsKey(k))
                w.put(k, 1+(int)w.get(k));
            else
                w.put(k,1);
        }
        StringBuffer s = new StringBuffer();
        String c = "";
        for (String k : new TreeSet<>(w.keySet())) {
            String r = new StringBuffer(k).reverse().toString();
            if (!w.containsKey(r))
                continue;
            int m = Math.min(w.get(k), w.get(r));
            w.put(k,0);
            if (k.equals(r)) {
                if (m % 2 == 1 && (c.isEmpty() || k.compareTo(c) < 0))
                    c = k;
                m /= 2;
            }
            for (; m > 0; m--)
                s.append(k);
        }
        System.out.println(s + c + s.reverse());
    }
}
