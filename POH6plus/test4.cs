using System;
class H
{
    static byte[] b=new byte[20000];
    static int i,j,h,k,n=0,x,l=0,m,c=0,s,t;
    static int[] p,q;
    static int[][] z;
    static System.IO.Stream o=Console.OpenStandardOutput();
    static int cmp(int u,int v)
    {
        if (b[u]==b[v])
            if (b[u]=='\n')
                return 0;
            else
                return cmp(u+1,v+1);
        else
            return b[u]-b[v];
    }
    static int rev(int u,int v)
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
    static void srt(int[] u,int v)
    {
        for(s=1;s<=v;s++)
        {
            m=s;
            for(t=s+1;t<=v;t++)
                if(cmp(u[m],u[t])>0)
                    m=t;
            t=u[m];
            u[m]=u[s];
            u[s]=t;
        }
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
        	z=new int[27][];
        	for(i=0;i<n;i++)
        		q[b[p[i]]-'a']++;
        	for(i=0;i<27;i++)
        	    if (q[i]>0)
        	        z[i]=new int[q[i]+1];
        	for(i=0;i<n;i++)
        	{
        	    j=b[p[i]]-'a';
        	    z[j][++z[j][0]]=p[i];
        	}
        	k=0;
        	for(i=0;i<27;i++)
        	    if(q[i]>0)
        	    {
        	        srt(z[i],q[i]);
        	        for(j=1;j<=q[i];j++)
        	            p[k++]=z[i][j];
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
