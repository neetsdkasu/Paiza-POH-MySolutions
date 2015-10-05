/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/da72c10b
 */
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        
        Scanner in = new Scanner(System.in);
        
        int n = in.nextInt();
        
        double c = 0.0, w = 0.0;
        
        for (int i = 0; i < n; i++) {
            int t = in.nextInt();
            double s = in.nextDouble();
            switch (t) {
            case 1: w += s; break;
            case 2: c += s; break;
            case 3:
                double tw = (w * (w + c) - s * w) / (w + c);
                double tc = (c * (w + c) - s * c) / (w + c);
                w = tw;
                c = tc;
                break;
            }
        }
        
        int ans = (int)(100.0 * c / (w + c));
        
        System.out.println(ans);
        
    }
}
