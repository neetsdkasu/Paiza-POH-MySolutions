/* paiza POH! Lite
* result:
*
* author: Leonardone @ NEETSDKASU
*/
import java.io.*;
import java.lang.*;
import java.util.*;

class Main
{
    static byte[] buf = new byte[2000];
    static int bufindex = 0;
   
    static int nextInt() {
        int n = 0;
        int b = (int)buf[bufindex];
        while (b < '0' || b > '9') {
            b = (int)buf[++bufindex];
        }
        while (b >= '0' && b <= '9') {
            n = n * 10 + (int)(b) - '0';
            b = (int)buf[++bufindex];
        }
        return n;
    }
   
    static int[][] a = new int[51][500001];
    static int[] q = new int[51];
    static int[] r = new int[51];

    public static void main (String[] args) throws java.lang.Exception
    {
       
        int m;
        int n;
       
        int w = 0, p = 0;
       
        int i, j, x, y;
        int[] t0, t1;
       
        System.in.read(buf);
       
        m = nextInt();
        n = nextInt();

        for (i = 0; i < n; i++) {
            q[i] = nextInt();
            r[i] = nextInt();
            w += q[i];
            p += r[i];
        }
        w -= m;
       
        for (i = 0; i < n; i++) {
            t0 = a[i];
            t1 = a[i + 1];
            for (j = 0; j <= w; j++) {
                if (q[i] <= j) {
                    x = t0[j];
                    y = t0[j - q[i]] + r[i];
                    t1[j] = (x > y) ? x : y;
                } else {
                    t1[j] = t0[j];
                }
            }
        }
       
        System.out.println(p - a[n][w]);

    }
}
