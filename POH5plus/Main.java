//////////////////////////////////////
// 15 puzzle solver                 //
//                                  //
// 2015-04-26                       //
// Leonardone @ NEETSDKASU          //
//////////////////////////////////////
import java.io.*;
import java.util.*;


class Main
{
	static boolean[] flags = new boolean[16];
	static Map<Long, Long> map;
	static Puzzle problem;

	static {
		problem = getProblem();
		map = makeRoot();
	}
	
	
	public static void main(String[] args) throws Exception {
		
		int p1 = problem.getPos(1L);
		int p2 = problem.getPos(2L);
		if (p1 < p2) {
			if (p2 > 5) {
				if ((p2 & 3) == 0) {
					solve3(p2, 4);
				} else {
					solve3(p2, 5);
				}
			}
		}
		
		solve3(problem.getPos(1L), 0);
		flags[0] = true;
		solve3(problem.getPos(2L), 1);
		flags[1] = true;
		solve3(problem.getPos(5L), 4);
		flags[4] = true;
		solve3(problem.getPos(6L), 5);
		flags[5] = true;
		
		if (problem.getPos(3L) > 7) {
			solve3(problem.getPos(3L), 3);
		}
		if (problem.getPos(4L) > 7) {
			solve3(problem.getPos(4L), 3);
		}
		
		if (solve1()) {
			return;
		}
		
		if (solve2()) {
			return;
		}
		
	}
	
	static boolean seekRoot(int[] rt, int s, int g) {
		int c = 1;
		rt[g] = c;
		while (rt[s] == 0) {
			boolean fz = false;
			for (int i = 0; i < 16; i++) {
				if (rt[i] != c) {
					continue;
				}
				if (i - 4 >= 0 && rt[i - 4] == 0 && !flags[i - 4]) {
					rt[i - 4] = c + 1;
					fz = true;
				}
				if (i + 4 < 16 && rt[i + 4] == 0 && !flags[i + 4]) {
					rt[i + 4] = c + 1;
					fz = true;
				}
				if ((i & 3) != 0 && i - 1 >= 0 && rt[i - 1] == 0 && !flags[i - 1]) {
					rt[i - 1] = c + 1;
					fz = true;
				}
				if ((i & 3) != 3 && i + 1 < 16 && rt[i + 1] == 0 && !flags[i + 1]) {
					rt[i + 1] = c + 1;
					fz = true;
				}
			}
			c++;
			if (!fz) {
				return false;
			}
		}
		return true;
	}
	
	static void solve3(int pn, int g) {
		if (flags[g] || flags[pn] || pn == g) {
			return ;
		}
		int p0 = problem.getPos(0L);
		
		int[] r1 = new int[16];
		
		seekRoot(r1, pn, g);
		
		for (int cn = r1[pn] - 1; cn > 0; cn--) {
			int pi = -1;
			
			// a 4
			if (pn + 4 < 16 && r1[pn + 4] == cn) {
				pi = pn + 4;
			}
			
			// a 3
			if (pn - 4 >= 0 && r1[pn - 4] == cn) {
				pi = pn - 4;
			}
			
			// a 1
			if ((pn & 3) != 0 && pn - 1 >= 0 && r1[pn - 1] == cn) {
				pi = pn - 1;
			}
			
			// a 2
			if ((pn & 3) != 3 && pn + 1 < 16 && r1[pn + 1] == cn) {
				pi = pn + 1;
			}
			
			Puzzle temp;
			int[] r0 = new int[16];
			boolean f1 = flags[pn];
			flags[pn] = true;
			seekRoot(r0, p0, pi);
			flags[pn] = f1;
			for (int c0 = r0[p0] - 1; c0 > 0; c0--) {
				
				// b 4
				if ((p0 & 3) != 3 && p0 + 1 < 16 && r0[p0 + 1] == c0) {
					temp = problem.moveRight();
					p0++;
				} else 
				
				// b 3
				if ((p0 & 3) != 0 && p0 - 1 >= 0 && r0[p0 - 1] == c0) {
					temp = problem.moveLeft();
					p0--;
				} else
				
				// b 1
				if (p0 - 4 >= 0 && r0[p0 - 4] == c0) {
					temp = problem.moveUp();
					p0 -= 4;
				} else
				
				// b 2
				if (p0 + 4 < 16 && r0[p0 + 4] == c0) {
					temp = problem.moveDown();
					p0 += 4;
				} else
				
				{
					System.out.println("are?");
					return;
				}
				System.out.println(Puzzle.moveNumber(temp.data, problem.data));
				problem = temp;
			}
			
			if (pi == pn - 1) {
				temp = problem.moveRight();
				p0++;
			} else
			if (pi == pn + 1) {
				temp = problem.moveLeft();
				p0--;
			} else
			if (pi == pn - 4) {
				temp = problem.moveDown();
				p0 += 4;
			} else
			if (pi == pn + 4) {
				temp = problem.moveUp();
				p0 -= 4;
			} else
			{
				System.out.println("arere?");
				return;
			}
			System.out.println(Puzzle.moveNumber(temp.data, problem.data));
			problem = temp;
			pn = pi;
		}
	}
	
	static Puzzle getProblem() {
		BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
		long[] data = new long[16];
		int n = 0;
		try {
			for (int i = 0; i < 4; i++) {
				String[] str = in.readLine().split(" ");
				for (String s : str) {
					if (!"*".equals(s)) {
						data[n] = Long.parseLong(s);
					}
					n++;
				}
			}
		} catch (IOException e) {
		}
		return new Puzzle(data);
	}
	
	static Map<Long, Long> makeRoot() {
		Map<Puzzle, Long> hs1 = new HashMap<>(200000), hs2 = new HashMap<>(200000), hs3;
		Map<Long, Long> map = new HashMap<>(400000);
		
		{
			Puzzle pzl = new Puzzle();
			hs1.put(pzl, pzl.data);
			map.put(pzl.data, 0L);
		}
		
		for (int i = 1; i <= 22; i++) {
			hs2.clear();
			for (Puzzle pzl : hs1.keySet()) {
				Long pd = hs1.get(pzl);
				for (int j = 0; j < 4; j++) {
					Puzzle temp;
					if ((temp = pzl.move(j)) == pzl) {
						continue;
					}
					if ((temp.z & 0xFF00_FF00_0000_0000L) != 0L) {
						continue;
					}
					Long d = temp.data;
					if (map.containsKey(d) || map.containsKey(Puzzle.symmetry(temp.data))) {
						continue;
					}
					map.put(d, pd);
					hs2.put(temp, d);
				}
			}
			hs3 = hs1;
			hs1 = hs2;
			hs2 = hs3;
		}
		return map;
	}
	
	static boolean solve1() {
		
		Long d = problem.data;
		Long s = Puzzle.symmetry(problem.data);
		
		if (map.containsKey(d)) {
			for (;;) {
				Long temp = map.get(d);
				if (temp == 0L) {
					break;
				}
				System.out.println(Puzzle.moveNumber(temp, d));
				d = temp;
			}
			return true;
		} else if (map.containsKey(s)) {
			d = s;
			for (;;) {
				Long temp = map.get(d);
				if (temp == 0L) {
					break;
				}
				System.out.println(Puzzle.symmetryNumber(Puzzle.moveNumber(temp, d)));
				d = temp;
			}
			return true;
		} else {
			return false;
		}
	}
	
	static boolean solve2() {
		Map<Puzzle, Long> hs1 = new HashMap<>(200000), hs2 = new HashMap<>(200000), hs3;
		Map<Long, Long> map2 = new HashMap<>(400000);
		
		hs1.put(problem, problem.data);
		map2.put(problem.data, 0L);
		
		for (int i = 0; i < 100; i++) {
			hs2.clear();
			for (Puzzle pzl : hs1.keySet()) {
				Long pd = hs1.get(pzl);
				for (int j = 0; j < 4; j++) {
					Puzzle temp;
					if ((temp = pzl.move(j)) == pzl) {
						continue;
					}
					if ((temp.z & 0xFF00_FF00_0000_0000L) != 0L) {
						continue;
					}
					Long d = temp.data;
					Long s = Puzzle.symmetry(temp.data);
					if (map2.containsKey(d) || map2.containsKey(s)) {
						continue;
					}
					hs2.put(temp, d);
					map2.put(d, pd);
					if (map.containsKey(d) || map.containsKey(s)) {
						Deque<Long> list = new ArrayDeque<>(i + 5);
						
						for (;;) {
							Long t = map2.get(d);
							if (t.longValue() == 0L) {
								break;
							}
							list.addLast(Puzzle.moveNumber(t, d));
							d = t;
						}
						while (!list.isEmpty()) {
							System.out.println(list.removeLast());
						}
						problem = temp;
						solve1();
						return true;
					}
				}
			}
			hs3 = hs1;
			hs1 = hs2;
			hs2 = hs3;
		}
		return false;
	}

	
}


final class Puzzle
{
	private static final long[] symmetry_table = {0L, 1L, 5L, 9L, 13L, 2L, 6L, 10L, 14L, 3L, 7L, 11L, 15L, 4L, 8L, 12L};
	public static long symmetry(long data) {
		for (int i = 60; i >= 0; i -= 4) {
			data = (data & ~(0xFL << i)) | (symmetry_table[(int)((data >> i) & 0xFL)] << i);
		}
		return (0xF000_0F00_00F0_000FL & data)
			 | ((0x0F00_00F0_000F_0000L & data) >> 12)
			 | ((0x0000_F000_0F00_00F0L & data) << 12)
			 | ((0x00F0_000F_0000_0000L & data) >> 24)
			 | ((0x0000_0000_F000_0F00L & data) << 24)
			 | ((0x000F_0000_0000_0000L & data) >> 36)
			 | ((0x0000_0000_0000_F000L & data) << 36); 
	}
	public static long symmetryNumber(long n) {
		return symmetry_table[(int)(n & 0xFL)];
	}
	public static long set(long data, int index, long n) {
		int k = 60 - (index & 0xF) * 4;
		return (data & ~(0xFL << k)) | ((n & 0xFL) << k);
	}
	public static long moveNumber(long data1, long data2) {
		long x = data1 ^ data2;
		for (int i = 0; i < 16; i++) {
			if ((x & 0xF) != 0L) {
				return x & 0xF;
			}
			x >>= 4;
		}
		return 0L;
	}
	
	public final long data, z;
	final int  hash;
	public Puzzle() {
		long data = 0L;
		for (long i = 1L; i < 16L; i++) {
			data |= i << (64L - (i << 2));
		}
		this.data = data;
		this.z = 0xFL;
		hash = (int)(((data >> 32) ^ data) & 0xFFFF_FFFF);
	}
	public Puzzle(long[] n) {
		long data = 0L;
		int zi = 0;
		for (int i = 0; i < 16; i++) {
			if (n[i] == 0) {
				zi = i;
			} else {
				data |= (n[i] & 0xFL) << (60L - (i << 2));
			}
		}
		this.data = data;
		this.z = 0xFL << (60L - (zi << 2));
		hash = (int)(((data >> 32) ^ data) & 0xFFFF_FFFF);
	}
	public Puzzle(long data) {
		long z = 0xFL;
		while ((data & z) != 0L) {
			z <<= 4;
			if (z == 0xFL) {
				throw new IllegalArgumentException("data(" + data + ")");
			}
		}
		this.data = data;
		this.z = z;
		hash = (int)(((data >> 32) ^ data) & 0xFFFF_FFFF);
	}
	public Puzzle(Puzzle puzzle) {
		this.data = puzzle.data;
		this.z = puzzle.z;
		hash = (int)(((data >> 32) ^ data) & 0xFFFF_FFFF);
	}
	private Puzzle(long data, long z) {
		this.data = data;
		this.z = z;
		hash = (int)(((data >> 32) ^ data) & 0xFFFF_FFFF);
	}
	
	public int getPos(long n) {
		for (int i = 0; i < 16; i++) {
			if (getNum(i) == n) {
				return i;
			}
		}
		return -1;
	}
	
	public long getNum(int index) {
		return (data >> (60 - (index << 2))) & 0xFL;
	}
	
	public Puzzle moveLeft() {
		if ((0xF000_F000_F000_F000L & z) == 0L) {
			return new Puzzle((data | ((data >> 4) & z)) & ~(z << 4), z << 4);
		} else {
			return this;
		}
	}
	
	public Puzzle moveRight() {
		if ((0xF00F_000F_000F_000FL & z) == 0L) {
			return new Puzzle((data | ((data << 4) & z)) & ~(z >> 4), z >> 4);
		} else if ((0x000F_000F_000F_000FL & z) == 0L) {
			return new Puzzle((data | ((data << 4) & z)) & 0xF0FF_FFFF_FFFF_FFFFL, 0x0F00_0000_0000_0000L);
		} else {
			return this;
		}
	}
	
	public Puzzle moveUp() {
		if ((0xFFFF_0000_0000_0000L & z) == 0L) {
			return new Puzzle((data | ((data >> 16) & z)) & ~(z << 16), z << 16);
		} else {
			return this;
		}
	}
	
	public Puzzle moveDown() {
		if ((0xF000_0000_0000_FFFFL & z) == 0L) {
			return new Puzzle((data | ((data << 16) & z)) & ~(z >> 16), z >> 16);
		} else if ((0x0000_0000_0000_FFFFL & z) == 0L) {
			return new Puzzle((data | ((data << 16) & z)) & 0xFFFF_0FFF_FFFF_FFFFL, 0x0000_F000_0000_0000L);
		} else {
			return this;
		}
	}
	
	public Puzzle move(int v) {
		switch (v & 3) {
		case 0: return moveLeft();
		case 1: return moveUp();
		case 2: return moveRight();
		case 3: return moveDown();
		default: return this;
		}
	}
	
	public @Override String toString() {
		StringBuilder sb = new StringBuilder(40);
		for (int j = 60; j >= 0; j -= 4) {
			long n = (data >> j) & 0xFL;
			if ((j & 0xF) == 12 && j < 60) {
				sb.append(System.lineSeparator());
			} else {
				sb.append(' ');
			}
			if (n < 10L) {
				sb.append(' ');
			}
			if (n == 0L) {
				sb.append('*');
			} else {
				sb.append(n);
			}
		}
		return sb.substring(1);
	}
	
	public @Override int hashCode() {
		return hash;
	}
	
	public @Override boolean equals(Object o) {
		//if (o == this) return true; if (o == null) return false;
		//if (!getClass().equals(o.getClass())) return false;
		return data == ((Puzzle)o).data;
	}
	
}
