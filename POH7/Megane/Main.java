// Try POH
// author: Leonardone @ NEETSDKASU
import java.io.*;
import java.util.*;
import java.math.*;
import java.text.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner in = new Scanner(System.in);
        
        int n = in.nextInt(); in.nextLine();
        
        String[] q = new String[n];
        
        for (int i = 0; i < n; i++) {
            q[i] = in.nextLine();
        }
        
        int m = in.nextInt(); in.nextLine();
        
        String[] p = new String[m];
        
        for (int i = 0; i < m; i++) {
            p[i] = in.nextLine();
        }
        
        outerloop:
        for (int i = 0; i <= n - m; i++) {
            innerloop:
            for (int j = 0; (j = q[i].indexOf(p[0], j)) >= 0; j++) {
                for (int k = 1; k < m; k++) {
                    int v = q[i + k].indexOf(p[k], j);
                    if (v < 0) {
                        continue outerloop;
                    }
                    if (v != j) {
                        continue innerloop;
                    }  
                }
                System.out.printf("%d %d%s", i, j / 2, System.lineSeparator());
            }
        }
        
    }
}
