// Try POH
// author: Leonardone @ NEETSDKASU
import java.io.*;
import java.util.*;
import java.util.function.*;
import java.util.regex.*;
import java.util.stream.*;

public class Main {
    
    static void solve(MyReader mr) throws Exception {
        
        int n = mr.gi();
        
        range(n).forEach( i -> print("Ann") );
        println();
        
    }
    
    // ==================================================================================
    static     int  ti(String s) { return Integer.parseInt(s); }
    static     long tl(String s) { return Long.parseLong(s); }
    static     void printf(String fmt, Object... args) { System.out.printf(fmt, args); }
    static     void printfn(String fmt, Object... args) { printf(fmt, args); println(); }
    static     void print(Object o) { System.out.print(o); }
    static     void print(String sep, Object... args) { print(args, sep); }
    static <T> void print(Iterable<T> itr, String sep) { int i = 0; for(T v : itr) { if(i++ > 0) print(sep); print(v); } }
    static <T> void print(T[] values, String sep) { int i = 0; for(T v : values) { if(i++ > 0) print(sep); print(v); } }
    static     void print(int[] values, String sep) { int i = 0; for(int v : values) { if(i++ > 0) print(sep); print(v); } }
    static     void println() { System.out.println(); }
    static     void println(Object o) { print(o); println(); }
    static     void println(String sep, Object... args) { print(sep, args); println(); }
    static <T> void println(Iterable<T> itr, String sep) { print(itr, sep); println(); }
    static <T> void println(T[] values, String sep) { print(values, sep); println(); }
    static     void println(int[] values, String sep) { print(values, sep); println(); }
    static     IntStream range(int n) { return IntStream.range(0, n); }
    static class MyReader {
        BufferedReader in;
        MyReader() { try { in = new BufferedReader(new InputStreamReader(System.in)); } catch (Exception e) {} }
        String     gs() { try { return in.readLine(); } catch (Exception e) { return ""; } }
        int        gi() { return ti(gs()); }
        long       gl() { return tl(gs()); }
        String[]   gss() { return gs().split(" "); } List<String> gssl() { return Arrays.asList(gss()); } Stream<String> gsss() { return Stream.of(gss()); }
        int[]      gis() { return giss().toArray(); } List<Integer> gisl() { return Arrays.asList(gsss().map(Integer::valueOf).toArray(Integer[]::new)); } IntStream giss() { return gsss().mapToInt(Integer::parseInt); }
        String[]   ngs(int n) { return range(n).mapToObj( i -> gs() ).toArray(String[]::new); }
        int[]      ngi(int n) { return range(n).map( i -> gi() ).toArray(); }
        String[][] ngss(int n) { return range(n).mapToObj( i -> gss() ).toArray(String[][]::new); }
        int[][]    ngis(int n) { return range(n).mapToObj( i -> gis() ).toArray(int[][]::new); }
    }
    public static void main(String[] args) throws Exception { solve(new MyReader()); }
    // ==================================================================================
}
