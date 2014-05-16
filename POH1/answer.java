/* paiza POH! Vol.1
 * result:
 * http://paiza.jp/poh/ec-campaign/result/390c4a5bb8b4f46cebae48f70ee21c2e
 * author: Leonardone @ NEETSDKASU
 */
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.Arrays;
import java.io.PrintStream;

public class Main {
    static BufferedReader r;
    static PrintStream out;
    static int n;
    static int d;
    static int[] p;
    static int m, f, e, tmp, sum, ci, cp;
    static String[] str;
    static {
        r = new BufferedReader(
            new InputStreamReader(System.in));
        out = System.out;
        p = new int[200000];
    }
    public static void main (String[] args) throws Exception {
        // Java sun-jdk-1.7.0_10
        str = r.readLine().split(" ");
        n = Integer.parseInt(str[0]);
        d = Integer.parseInt(str[1]);
        for (int i = 0; i < n; ++i) {
            p[i] = Integer.parseInt(r.readLine());
        }
        Arrays.sort(p, 0, n);
        ci = (n - 1) >> 1;
        cp = p[ci];
        for (int i = 0; i < d; ++i) {
            m = Integer.parseInt(r.readLine());
            f = m < cp ? ci : n - 1;
            e = m - p[f] > cp ? ci : 0 ;
            tmp = 0;
            while (f != e) {
                sum = p[f] + p[e];
                if (sum > m)
                    --f;
                else {
                    if (sum > tmp) tmp = sum;
                    ++e;
                }
            }
            out.println(tmp);
        }
    }
}
