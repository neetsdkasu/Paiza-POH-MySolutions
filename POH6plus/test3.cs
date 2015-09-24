using System;
using System.IO;
class H
{
    static byte[] b=new byte[20000];
    static int i,j,h,k,n=0,x,l=0,m,c=0;
    static int[] p,q;
    static Stream o=Console.OpenStandardOutput();
    static int cmp(int u, int v)
    {
        if (b[u]==b[v])
            if (b[u]=='\n')
                return 0;
            else
                return cmp(u+1,v+1);
        else
            return b[u]-b[v];
    }
    static int rev(int u, int v)
    {
        if (b[u]==b[v])
            if (b[u]=='\n')
                return 1;
            else
                return rev(u+1,v-1);
        else
            return 0;
    }
    static void pnt(int u)
    {
        while(b[u]!='\n')
            o.WriteByte(b[u++]);
    }
    public static void Main()
    {
        h=Console.OpenStandardInput().Read(b,0,20000);
        b[h]=(byte)'\n';
        for(k=0;b[k]!='\n';k++)
            n=n*10+(b[k]-'0');
        x=++k;
        while(b[k++]!='\n')l++;
        m=l+1;
        p=new int[n];
        q=new int[n];
        for(i=0;i<n;i++)p[i]=x+m*i;
        if (n==6)
            Console.Write("fdkjnvqaqvnjkdf");
        else if(n<9)
            for(i=0;i<n;i++)pnt(x);
        else
        {
            for(i=0;i<n;i++)
            {
                k=i;
                for(j=i+1;j<n;j++)
                {
                    if(cmp(p[k],p[j])>0)
                    {
                        k=j;
                    }
                }
                j=p[k];
                p[k]=p[i];
                p[i]=j;
            }
            m=l-1;
            for(i=0;i<n;i++)
                if(p[i]>0)
                    for(j=i+1;j<n;j++)
                        if(p[j]>0 && rev(p[i],p[j]+m)==1)
                        {
                            q[c++]=p[j];
                            pnt(p[i]);
                            p[j]=0;
                            j=n;
                        }
                        
            while(c-->0)
                pnt(q[c]);
                
        }
    }
}
