Public Class q:Shared Function u$(s$):Dim c As Char,a()As Char=s.ToCharArray,i%=0,j%=a.Length-1:Do While i<j:c=a(i):a(i)=a(j):a(j)=c:i+=1:j-=1:Loop:Return New String(a):End Function:Shared Function Main%:Dim n%=Int32.Parse(Console.ReadLine),w(n+1)As String,v$="",c$="",x$,y$,k%,i%:For i=1To n:w(i)=Console.ReadLine:Next:Array.Sort(w,1,n):For i=1To n:x=w(i):If x.Length=0Then Continue For
y=u(x):k=Array.IndexOf(w,y,i+1):If k=-1Then:If String.Compare(x,y)=0And(c.Length=0Or String.Compare(x,c)<0)Then c=x
Else:v+=x:w(k)="":End If:Next:Console.WriteLine(v+c+u(v)):Return 0:End Function:End Class
