// Try POH
// author: Leonardone @ NEETSDKASU
import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;

public class Main {
    
    void solve() throws Exception {
        
        int c1 = scni(), p1 = scni();
        int c2 = scni(), p2 = scni();
        
         println(c1 * p2 > c2 * p1 ? 1 : 2);
        
    }
    
    
    // ==================================================================================
    int        ti(String s) { return Integer.parseInt(s); }
    long       tl(String s) { return Long.parseLong(s); }
    IntStream  range(int n) { return IntStream.range(0, n); }
    String     gs() { return null; }
    int        gi() { return ti(gs()); }
    long       gl() { return tl(gs()); }
    String[]   gss() { return gs().split(" "); }
    int[]      gis() { String[] ss = gss(); int[] is = new int[ss.length]; for (int i = 0; i < ss.length; i++) is[i] = ti(ss[i]); return is; }
    String[]   ngs(int n) { String[] r = new String[n]; for (int i = 0; i < n; i++) r[i] = gs(); return r; }
    int[]      ngi(int n) { int[] r = new int[n]; for (int i = 0; i < n; i++) r[i] = gi(); return r; }
    String[][] ngss(int n) { String[][] r = new String[n][]; for (int i = 0; i < n; i++) r[i] = gss(); return r; }
    int[][]    ngis(int n) { int[][] r = new int[n][]; for (int i = 0; i < n; i++) r[i] = gis(); return r; }
    void       println() { System.out.println(); }
    void       print  (Object o) { System.out.print(o); }
    void       println(Object o) { print(o); println(); }
    void       print  (String sep, Object... args) { print(args, sep); }
    void       println(String sep, Object... args) { print(sep, args); println(); }
    <T> void   print  (Iterable<T> itr, String sep) { int i = 0; for(T v : itr) { if(i++ > 0) print(sep); print(v); } }
    <T> void   println(Iterable<T> itr, String sep) { print(itr, sep); println(); }
    <T> void   print  (T[] values, String sep) { int i = 0; for(T v : values) { if(i++ > 0) print(sep); print(v); } }
    <T> void   println(T[] values, String sep) { print(values, sep); println(); }
    void       print  (int[] values, String sep) { int i = 0; for(int v : values) { if(i++ > 0) print(sep); print(v); } }
    void       println(int[] values, String sep) { print(values, sep); println(); }
    void       printf (String fmt, Object... args) { System.out.printf(fmt, args); }
    void       printfn(String fmt, Object... args) { printf(fmt, args); println(); }
    Integer[]  boxed(int[] v) { Integer[] r = new Integer[v.length]; int i = 0; for (int x : v) r[i++] = x; return r; }
    int[]      unboxed(Integer[] v) { int[] r = new int[v.length]; int i = 0; for (int x : v) r[i++] = x; return r; }
    int[]      toIntArray(Collection<? extends Number> v) { int[] r = new int[v.size()]; int i = 0; for (Number x : v) r[i++] = x.intValue(); return r; }
    String     scns() { return null; }
    int        scni() { return ti(scns()); }
    String     scnln() { return null; }
    void       init() { }
    public static void main(String[] args) throws Exception {
        Main m = new Main(){
            BufferedReader in = null;
            @Override void init() { try { if (in == null) in = new BufferedReader(new InputStreamReader(System.in)); } catch (Exception e) {} }
            @Override String gs() { try { return in.readLine(); } catch (Exception e) { return null; } }
            int cur = 0; String[] buf = null;
            void next() { while (buf == null || buf.length == cur) { buf = gss(); cur = 0; } }
            @Override String scns() { next();  return buf[cur++]; }
            @Override String scnln() { next(); buf = Arrays.copyOfRange(buf, cur, buf.length); cur = buf.length; return String.join(" ", buf); }
        }; m.init(); m.solve();
    }
    // ==================================================================================
}
