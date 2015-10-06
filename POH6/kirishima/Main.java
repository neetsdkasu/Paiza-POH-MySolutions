/*
 * 結果 https://paiza.jp/poh/joshibato/kirishima/result/1d775f73
 */
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner in = new Scanner(System.in);
        
        int n = in.nextInt();
        
        int[] t = new int[n];
        for (int i = 0; i < n; i++) {
            t[i] = in.nextInt();
        }
        
        int m = in.nextInt();
        
        for (int i = 0; i < m; i++) {
            int d = in.nextInt();
            boolean[] flag = new boolean[n];
            String res = "No";
            for (;;) {
                if (d < 1 || d >= n) {
                    break;
                }
                if (d == n - 1) {
                    res = "Yes";
                    break;
                }
                if (t[d] == 0) {
                    break;
                }
                if (flag[d]) {
                    break;
                }
                flag[d] = true;
                d += t[d];
            }
            System.out.println(res);
        }
        
    }
}
