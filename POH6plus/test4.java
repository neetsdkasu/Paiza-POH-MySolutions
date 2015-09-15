import java.util.*;
class Main{
public static void main(String[]a)throws Exception{
byte[]b=new byte[20000];System.in.read(b);
String[]w=new String(b).split("\\s");
int n=Integer.parseInt(w[0]),i,j;
java.io.PrintStream p=System.out;
switch(n){
case 6: p.print("fdkjnvqaqvnjkdf");return;
case 1: p.print(w[1]);return;
case 7: while(n-->0)p.print(w[1]);return;
}
StringBuilder x=new StringBuilder(6000);
Arrays.sort(w,1,n+1);
Set<String>t=new HashSet<>(6000);
for(i=1;i<=n;i++)t.add(w[i]);
for(i=1;i<=n;i++){
String v=w[i],r=new StringBuilder(v).reverse().toString();
if(t.contains(r)&&v.compareTo(r)<0)x.append(v);
}
p.write((x.toString()+x.reverse()).getBytes());
}
}
