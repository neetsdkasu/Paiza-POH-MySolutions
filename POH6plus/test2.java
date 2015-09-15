import java.util.*;
class Main {
    public static void main(String[]a)throws Exception {
        byte[]b=new byte[20000];System.in.read(b);
        String[]w=new String(b).split("\\s");
        StringBuilder x=new StringBuilder(9000),c=new StringBuilder();
        int n=Integer.parseInt(w[0]),i,j;
        Arrays.sort(w,1,n+1);
        Set<String>t=new HashSet<>();
        for(i=1;i<=n;i++)t.add(w[i]);
        for(i=1;i<=n;i++){
            String v=w[i],r=new StringBuilder(v).reverse().toString();
            if(r.equals(v))c.append(r);
            else if(t.contains(r)&&v.compareTo(r)<0)x.append(v);
        }
        System.out.print(x.toString()+c+x.reverse());
    }
}
