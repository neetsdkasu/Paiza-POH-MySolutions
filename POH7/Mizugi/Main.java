// Try POH
// author: Leonardone @ NEETSDKASU
import java.io.*;
import java.util.*;

public class Main {
    public static void main(String[] args) throws Exception {
        Scanner in = new Scanner(System.in);
        
        final long MOD = 1_000_000_000L;
        long n = in.nextLong();
        long r = 1L, b = 0L;
        
        for (long i = 1; i <= n; i++) {
            long t = i;
            while (t % 2L == 0L) {
                t /= 2L;
                b++;
            }
            while (t % 5L == 0L) {
                t /= 5L;
                b--;
            }
            r = (r * t) % MOD;
        }
        
        for (long i = 0;+ i < b; i++) {
            r = (r * 2L) % MOD;
        }
        
        System.out.println(r);
    }
}
