/* paiza POH! vol.2
 * result:
 * http://paiza.jp/poh/paizen/result/654cc29c858239b822d3801436470917
 * author: Leonardone @ NEETSDKASU
 */
import java.util.*;
import java.lang.*;
import java.io.*;

class Main
{
	public static void main (String[] args) throws java.lang.Exception
	{
		BufferedReader in = new BufferedReader(
			new InputStreamReader(System.in));
		
		String[] hw = in.readLine().split(" ");
		int H = Integer.parseInt(hw[0]); // ãã¼ã ç»é¢ç¸¦ã®åºç»æ°
		int W = Integer.parseInt(hw[1]); // ãã¼ã ç»é¢æ¨ªã®åºç»æ°
		
		int[][] home = new int[H][W];
		int[][] result = new int[301][301];
		int count = 0;
		
		for (int y = 0; y < H; y++)
		{
			String line = in.readLine();
			for (int x = 0; x < W; x++)
			{
				if ((home[y][x] = (int)(line.charAt(x) - '0')) == 0)
				{
					count++;
				}
			}
		}
		result[1][1] = count;
		
		int[][][] table = new int[301][][];
		int right;
		
		int ww = W, hh;
		int[][] temp1, temp2;
		temp1 = table[1] = home;
		for (right = 2; right <= W; right++)
		{
			count = 0;
			ww--;
			temp2 = table[right] = new int[H][ww];
			for (int y = 0; y < H; y++)
			{
				for (int x = 0; x < ww; x++) 
				{
					if ((temp2[y][x] = temp1[y][x] | temp1[y][x + 1]) == 0)
					{
						count++;
					}
				}
			}
			result[1][right] = count;
			if (count < 2)
			{
				break;
			}
			temp1 = temp2;
		}
		
		ww = W + 1;
		for (int i = 1; i < right; i++)
		{
			ww--;
			temp1 = table[i];
			hh = H;
			for (int bottom = 2; bottom <= H; bottom++)
			{
				count = 0;
				hh--;
				for (int y = 0; y < hh; y++)
				{
					for (int x = 0; x < ww; x++)
					{
						if ((temp1[y][x] |= temp1[y + 1][x]) == 0)
						{
							count++;
						}
					}
				}
				result[bottom][i] = count;
				if (count < 2)
				{
					break;
				}
			}
		}
		
		int N = Integer.parseInt(in.readLine()); // ã¦ã£ã¸ã§ããæ°
		StringBuilder output = new StringBuilder(N * 6);

		for (int i = 0; i < N; i++)
		{
			String[] st = in.readLine().split(" ");
			int s = Integer.parseInt(st[0]); // ã¦ã£ã¸ã§ããã®ç¸¦ãµã¤ãº
			int t = Integer.parseInt(st[1]); // ã¦ã£ã¸ã§ããã®æ¨ªãµã¤ãº
			
			output.append(result[s][t]);
			output.append('\n');
		}
		
		System.out.print(output);
		
	} // end of main(String[])
	
}
