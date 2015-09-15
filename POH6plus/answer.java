import java.util.*;
class Main {
    public static void main(String[]a)throws Exception {
        byte[]b=new byte[20000];System.in.read(b);
        String[]w=new String(b).split("\\s");
        int n=Integer.parseInt(w[0]),i,j;
        String r,x="",y=x,c=x;
        Arrays.sort(w,1,n+1);
        for(i=1;i<=n;i++){
            r=new StringBuffer(w[i]).reverse().toString();
            for(j=i+1;j<=n&&!r.equals(w[j]);j++);
            if(j<=n){x+=w[i];y=r+y;w[j]="";}else if(r.equals(w[i]))c+=r;
        }
        System.out.print(x+c+y);       
    }
}
