// paiza POH! vol.2
// result:
// http://paiza.jp/poh/paizen/result/85b2f2c34976b832709f2a784a83712f
// author: Leonardone @ NEETSDKASU
using System;
using System.Text;

public class Test
{
	public static void Main()
	{
		String[] hw = Console.ReadLine().Split(' ');
		int h = Int32.Parse(hw[0]);
		int w = Int32.Parse(hw[1]);
		
		int[,] tb = new int[301, 301];
		int[] sp = new int[w];
		
		for (int y = 0; y < h; y++)
		{
			String line = Console.ReadLine();
			for (int x = 0; x < w; x++)
			{
				if (line[x] == '0')
				{
					sp[x]++;
					int s = sp[x];
					int t = 1;
					for (int i = x; i >= 0 && sp[i] > 0; i--)
					{
						if (sp[i] < s)
						{
							s = sp[i];
						}
						tb[s, t]++;
						t++;
					}
				}
				else
				{
					sp[x] = 0;
				}
			}
		}
		
		for (int x = 1; x <= w; x++)
		{
			for (int y = h - 1; y > 0; y--)
			{
				tb[y, x] += tb[y + 1, x];
			}
		}
		
		int n = Int32.Parse(Console.ReadLine());
		StringBuilder output = new StringBuilder(n * 6);
		
		for (int i = 0; i < n; i++)
		{
			String[] st = Console.ReadLine().Split(' ');
			int s = Int32.Parse(st[0]);
			int t = Int32.Parse(st[1]);
			output.Append(tb[s, t]);
			output.AppendLine();
		}
		Console.WriteLine(output);
	}
}
