/* paiza POH! vol.2
 * result:
 * http://paiza.jp/poh/paizen/result/c064b4324be2749f45a52b255bf21788
 * author: Leonardone @ NEETSDKASU
 */
import java.util.*;
import java.lang.*;
import java.io.*;

final class Main
{
	private static final BufferedReader s_in = new BufferedReader(
			new InputStreamReader(System.in));

	private static final int[][] s_table = new int[301][301];
		
	private static final int[] s_space2top = new int[300];

	private static final StringBuilder s_output = new StringBuilder(450000);
		
	
	public static void main (String[] args) throws java.lang.Exception
	{
		final BufferedReader in = s_in;
		final int[][] table = s_table;
		final int[] space2top = s_space2top;
		final StringBuilder output = s_output;
		
		int x, y, i, s, t;
		int[] temp1, temp2;
		String line;
		
		String[] hw = in.readLine().split(" ");
		final int H = Integer.parseInt(hw[0]); // ãã¼ã ç»é¢ç¸¦ã®åºç»æ°
		final int W = Integer.parseInt(hw[1]); // ãã¼ã ç»é¢æ¨ªã®åºç»æ°
		

		for (y = 0; y < H; y++) {
			line = in.readLine();
			for (x = 0; x < W; x++) {
				if (line.charAt(x) == '0') {
					space2top[x]++;
					s = space2top[x];
					t = 1;
					for (i = x; i >= 0 && space2top[i] > 0; i--) {
						if (space2top[i] < s) {
							s = space2top[i];
						}
						table[t][s]++;
						t++;
					}
				} else {
					space2top[x] = 0;
				}
			}
		}
		
		for (t = 1; t <= W; t++) {
			temp2 = table[t];
			for (s = H - 1; s > 0; s--) {
				temp2[s] = temp2[s] + temp2[s + 1];
			}
		}
		
		final int N = Integer.parseInt(in.readLine()); // ã¦ã£ã¸ã§ããæ°
		
		for (i = 0; i < N; i++)
		{
			hw = in.readLine().split(" ");
			s = Integer.parseInt(hw[0]); // ã¦ã£ã¸ã§ããã®ç¸¦ãµã¤ãº
			t = Integer.parseInt(hw[1]); // ã¦ã£ã¸ã§ããã®æ¨ªãµã¤ãº
			
			output.append(table[t][s]);
			output.append('\n');
		}
		
		System.out.print(output);
		
	} // end of main(String[])
}
