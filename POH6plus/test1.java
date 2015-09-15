class Main {
    public static void main(String[]a)throws Exception {
        byte[]b=new byte[20000];System.in.read(b);
        String[]w=new String(b).split("\\s");
        StringBuilder x=new StringBuilder(9000),c=new StringBuilder();
        int n=Integer.parseInt(w[0]),i,j;
        java.util.Arrays.sort(w,1,n+1);
        for(i=1;i<=n;i++){
            String v=w[i],r=new StringBuilder(v).reverse().toString();
            for(j=i+1;j<=n&&!r.equals(w[j]);j++);
            if(j<=n){x.append(v);w[j]="";}else if(r.equals(v))c.append(r);
        }
        System.out.print(x);
        System.out.print(c.append(x.reverse()));
    }
}
