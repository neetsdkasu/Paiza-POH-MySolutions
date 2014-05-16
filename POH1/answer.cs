// paiza POH! Vol.1
// result:
// http://paiza.jp/poh/ec-campaign/result/65e48d43b37402535955b30426089dbc
// author: Leonardone @ NEETSDKASU
using System;

public class Test
{
	public static void Main()
	{
		string[] nd = Console.ReadLine().Split(' ');
		int n = Int32.Parse(nd[0]);
		int d = Int32.Parse(nd[1]);
		int[] p = new int[n];
		for (int i = 0; i < n; i++) {
			p[i] = Int32.Parse(Console.ReadLine());
		}
		Array.Sort(p);
		for (int k = 0; k < d; k++) {
			int m = Int32.Parse(Console.ReadLine());
			int tmp = 0;
			int i = 0;
			int j = n - 1;
			while (i != j) {
				int sum = p[i] + p[j];
				if (sum > m) {
					j--;
				} else {
					if (sum > tmp) {
						tmp = sum;
						if (tmp == m) {
							break;
						}
					}
					i++;
				}
			}
			Console.WriteLine(tmp);
		}
	}
}
