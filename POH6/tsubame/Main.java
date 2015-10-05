/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/ee79f099
 */
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner in = new Scanner(System.in);
        
        String n_str = in.next();
        
        int n = Integer.parseInt(n_str);
        int n1 = Integer.parseInt(n_str.substring(1,2));
        int n10 = Integer.parseInt(n_str.substring(0,1));
        int r = n + n1 + n10;
        
        System.out.println(r);
        
    }
}
