// Try POH
// author: Leonardone @ NEETSDKASU
import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner in = new Scanner(System.in);
        
        int x = in.nextInt();
        int y = in.nextInt();
        int z = in.nextInt();
        int n = in.nextInt();
        
        int[][] xy = new int[2][n];
        int[] xyc = {0, 0};
        
        int minxy[] = {x, y};
        
        for (int i = 0; i < n; i++) {
            int d = in.nextInt();
            int a = in.nextInt();
            minxy[d] = Math.min(minxy[d], Math.min(a, (d == 0 ? x : y) - a));
            for (int j = 0; j < xyc[d]; j++) {
                minxy[d] = Math.min(minxy[d], Math.abs(xy[d][j] - a));
            }
            xy[d][xyc[d]] = a;
            xyc[d]++;
        }
        
        System.out.println(z * minxy[0] * minxy[1]);
        
    }
}
