// Try POH
// author: Leonardone @ NEETSDKASU
import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;

public class Main {
    
    void solve() throws Exception {
        
        int a = gi(), b = gi();
        
        println(a + b);        
        
    }
    
    
    // ==================================================================================
    int        ti(String s) { return Integer.parseInt(s); }
    long       tl(String s) { return Long.parseLong(s); }
    IntStream  range(int n) { return IntStream.range(0, n); }
    String     gs() { try { return in.readLine(); } catch (Exception e) { return ""; } }
    int        gi() { return ti(gs()); }
    long       gl() { return tl(gs()); }
    String[]   gss() { return gs().split(" "); } List<String> gssl() { return Arrays.asList(gss()); } Stream<String> gsss() { return Stream.of(gss()); }
    int[]      gis() { return giss().toArray(); } List<Integer> gisl() { return Arrays.asList(gsss().map(Integer::valueOf).toArray(Integer[]::new)); } IntStream giss() { return gsss().mapToInt(Integer::parseInt); }
    String[]   ngs(int n) { return range(n).mapToObj( i -> gs() ).toArray(String[]::new); }
    int[]      ngi(int n) { return range(n).map( i -> gi() ).toArray(); }
    String[][] ngss(int n) { return range(n).mapToObj( i -> gss() ).toArray(String[][]::new); }
    int[][]    ngis(int n) { return range(n).mapToObj( i -> gis() ).toArray(int[][]::new); }
    void       printf(String fmt, Object... args) { System.out.printf(fmt, args); }
    void       printfn(String fmt, Object... args) { printf(fmt, args); println(); }
    void       print(Object o) { System.out.print(o); }
    void       print(String sep, Object... args) { print(args, sep); }
    <T> void   print(Iterable<T> itr, String sep) { int i = 0; for(T v : itr) { if(i++ > 0) print(sep); print(v); } }
    <T> void   print(T[] values, String sep) { int i = 0; for(T v : values) { if(i++ > 0) print(sep); print(v); } }
    void       print(int[] values, String sep) { int i = 0; for(int v : values) { if(i++ > 0) print(sep); print(v); } }
    void       println() { System.out.println(); }
    void       println(Object o) { print(o); println(); }
    void       println(String sep, Object... args) { print(sep, args); println(); }
    <T> void   println(Iterable<T> itr, String sep) { print(itr, sep); println(); }
    <T> void   println(T[] values, String sep) { print(values, sep); println(); }
    void       println(int[] values, String sep) { print(values, sep); println(); }
    BufferedReader in;
    Main() { try { in = new BufferedReader(new InputStreamReader(System.in)); } catch (Exception e) {} }
    public static void main(String[] args) throws Exception { new Main().solve(); }
    // ==================================================================================
}
