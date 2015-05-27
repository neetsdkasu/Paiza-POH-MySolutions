
object PuzzleUtil {
	def shift(index: Int): Int = 60 - (index << 2)
	def getNumber(data: Long, index: Int): Int = ((data >> shift(index)) & 0xFL).asInstanceOf[Int]
	def getIndex(data: Long, value: Int): Int = {
		val lValue = (data & 0xFL) ^ (0xF & value).asInstanceOf[Long]
		if (lValue == 0L)
			15
		else
			if (data == 0L)
				-1
			else
				getIndex(data >> 4, value) - 1
	}
	def setNumber(data: Long, index: Int, value: Int): Long = {
		val sh = shift(index)
		val lValue = (0xF & value).asInstanceOf[Long]
		(data & (~(0xFL << sh))) | (lValue << sh)
	}
	val costMap = {
		def calcCostMap(m: Map[Long, Int], i: Int, n: Int): Map[Long, Int] = {
			if (n >= 15)
				m + (0L -> 0)
			else {
				val x = ((i & 3) - (n & 3)).abs
				val y = ((i >> 2) - (n >> 2)).abs
				val c = x + y
				val k = setNumber(0L, i, (n + 1))
				val nx = if (i == 15) (n + 1) else n
				calcCostMap((m + (k -> c)), ((i + 1) & 15), nx)
			}
		}
		calcCostMap(Map(), 0, 0)
	}
	def calcCost(data: Long): Int = {
		def calcCostLoop(cost: Int, i:Int): Int = {
			if (i == 16)
				cost
			else {
				val k = getNumber(data, i).asInstanceOf[Long] << shift(i)
				val c = cost + costMap(k)
				calcCostLoop(c, (i + 1))
			}
		}
		calcCostLoop(0, 0)
	}
}

class Puzzle(val data: Long, val zero: Long, val cost: Int) {
	def this(data: Long) = this(data,  PuzzleUtil.setNumber(0L, PuzzleUtil.getIndex(data, 0), 0xF), PuzzleUtil.calcCost(data))
	def this() = this(0x123456789abcdef0L)
	def numberOf(index: Int) = PuzzleUtil.getNumber(data, index)
	def indexOf(value: Int) = PuzzleUtil.getIndex(data, value)
	def moveLeft = {
		if ((0xF000F000F000F000L & zero) == 0L) {
			val z = zero << 4
			val v = (data >> 4) & zero
			val d = (data & (~z)) | v
			val c = cost + PuzzleUtil.costMap(v) - PuzzleUtil.costMap(data & z)
			new Puzzle(d, z, c)
		} else {
			this
		}
	}
	def moveRight = {
		if ((0x000F000F000F000FL & zero) == 0L) {
			val z = (zero >> 4) & 0x0FFFFFFFFFFFFFFFL
			val v = (data << 4) & zero
			val d = (data & (~z)) | v
			val c = cost + PuzzleUtil.costMap(v) - PuzzleUtil.costMap(data & z)
			new Puzzle(d, z, c)
		} else {
			this
		}
	}
	def moveUp = {
		if ((0xFFFF000000000000L & zero) == 0L) {
			val z = zero << 16
			val v = (data >> 16) & zero
			val d = (data & (~z)) | v
			val c = cost + PuzzleUtil.costMap(v) - PuzzleUtil.costMap(data & z)
			new Puzzle(d, z, c)
		} else {
			this
		}
	}
	def moveDown = {
		if ((0x000000000000FFFFL & zero) == 0L) {
			val z = (zero >> 16) & 0x0000FFFFFFFFFFFFL
			val v = (data << 16) & zero
			val d = (data & (~z)) | v
			val c = cost + PuzzleUtil.costMap(v) - PuzzleUtil.costMap(data & z)
			new Puzzle(d, z, c)
		} else {
			this
		}
	}
	def move(k: Int) = k match {
		case 0 => moveLeft
		case 1 => moveRight
		case 2 => moveUp
		case 3 => moveDown
		case _ => this
	}
	def moveNumber(n: Int) = (indexOf(n) - indexOf(0)) match {
		case -4 => moveUp
		case -1 => moveLeft
		case 1 => moveRight
		case 4 => moveDown
		case _ => this
	}
	def shuffle = {
		val d = new java.util.Date()
		val r = new scala.util.Random(d.getTime())
		def shf(p: Puzzle, c: Int): Puzzle = {
			if (c <= 0)
				p
			else {
				val k = r.nextInt(4)
				shf(p.move(k), (c - 1))
			}
		}
		shf(this, 1000)
	}
	def print = {
		Console.println("-----------------")
		for (i <- 0 until 16) {
			if ((i & 3) > 0)
				Console.print(" ")
			val n = numberOf(i)
			if (n > 0)
				Console.printf("%2d", n)
			else
				Console.print(" *")
			if ((i & 3) == 3)
				Console.println()
		}
	}
}

object Solver {
	
	type RootMap = Map[Long, Long]
	type SeekMap = Map[Long, Puzzle]
	type Result = (Boolean, SeekMap, RootMap)

	def step(gl: Long, fl: Long, pz:Puzzle, k: Int, nx: SeekMap, rt: RootMap): Result = {
		if (k >= 4)
			(false, nx, rt)
		else {
			val mv = pz.move(k)
			if (pz.data == mv.data)
				step(gl, fl, pz, (k + 1), nx, rt)
			else {
				if ((mv.zero & fl) != 0L)
					step(gl, fl, pz, (k + 1), nx, rt)
				else {
					if (rt.contains(mv.data))
						step(gl, fl, pz, (k + 1), nx, rt)
					else {
						val rt2 = rt + (mv.data -> pz.data)
						if (mv.data == gl)
							(true, nx, rt2)
						else {
							val nx2 = nx + (mv.data -> mv)
							step(gl, fl, pz, (k + 1), nx2, rt2)
						}
					}
				}
			}
		}
	}
	
	def seek(gl: Long, fl: Long, cu: SeekMap, nx: SeekMap, rt: RootMap): Result = {
		if (cu.isEmpty) 
			(false, nx, rt)
		else {
			val (ky, pz) = cu.head
			val (res, nx2, rt2) = step(gl, fl, pz, 0, nx, rt)
			if (res)
				(true, nx2, rt2)
			else
				seek(gl, fl, cu.tail, nx2, rt2)
		}
	}
	
	def seekRoot(gl: Long, fl: Long, cu: SeekMap, rt: RootMap): (Boolean, RootMap) = {
		if (cu.isEmpty)
			(false, rt)
		else {
			val (res, nx, rt2) = seek(gl, fl, cu, Map(), rt)
			if (res)
				(true, rt2)
			else
				seekRoot(gl, fl, nx, rt2)
		}
	}
	
	def move(gl: Long, fl: Long, st: Puzzle) = {
		
		def f1(i: Int, z: Long): Long = {
			if (i >= 16)
				z
			else {
				val n = st.numberOf(i)
				val j = PuzzleUtil.getIndex(gl, n)
				if (j >= 0)
					f1((i + 1), PuzzleUtil.setNumber(z, i, n))
				else
					f1((i + 1), PuzzleUtil.setNumber(z, i, 0xB))
			}
		}
		def f2(i: Int, z: Long): Long = {
			if (i >= 16)
				z
			else {
				val n = PuzzleUtil.getNumber(gl, i)
				if (n > 0)
					f2((i + 1), PuzzleUtil.setNumber(z, i, n))
				else
					f2((i + 1), PuzzleUtil.setNumber(z, i, 0xB))
			}
		}
		val stp = f1(0, 0L)
		val glp = f2(0, 0L)
		def f3(i: Int, nx: SeekMap, rt: RootMap): (SeekMap, RootMap) = {
			if (i >= 16)
				(nx, rt)
			else {
				val n = PuzzleUtil.getNumber(glp, i)
				if (n != 0xB)
					f3((i + 1), nx, rt)
				else {
					val g = PuzzleUtil.setNumber(glp, i, 0)
					val rt2 = rt + (g -> 0L)
					val nx2 = nx + (g -> new Puzzle(g))
					f3((i + 1), nx2, rt2)
				}
			}
		}
		val (nx, rt) = f3(0, Map(), Map())
		if (rt.contains(stp))
			st
		else {
			val (res, rt2) = seekRoot(stp, fl, nx, rt)
			def printRoot(pz: Puzzle, cu: Long): Puzzle = {
				if (rt2.contains(cu) == false) {
					Console.println("error")
					pz
				} else {
					val nx = rt2(cu)
					if (nx == 0L)
						pz
					else {
						val i = PuzzleUtil.getIndex(nx, 0)
						val nm = pz.numberOf(i)
						val pz2 = pz.moveNumber(nm)
						Console.println(nm)
						printRoot(pz2, nx)
					}
				}
			}
			printRoot(st, stp)
		}
	}
	
	def solve(pz: Puzzle): Puzzle = {
		val pz2 = move(0x1200000000000000L, 0L, pz)
		val pz3 = move(0x1234000000000000L, 0xFF00000000000000L, pz2)
		val pz4 = move(0x1234560000000000L, 0xFFFF000000000000L, pz3)
		val pz5 = move(0x1234567800000000L, 0xFFFFFF0000000000L, pz4)
		val pz6 = move(0x123456789000d000L, 0xFFFFFFFF00000000L, pz5)
		move(0x123456789abcdef0L, 0xFFFFFFFFF000F000L, pz6)
	}
	
}

object Main extends App {
	def inputPuzzle() = {
		def f(j: Int, i: Int, s: Array[String], v: Long): Long = {
			if (i >= 4)
				v
			else {
				val t = s(i)
				val x = if (t == "*") 0 else t.toInt
				val n = (j << 2) | i
				f(j, (i + 1), s, PuzzleUtil.setNumber(v, n, x))
			}
		}
		def g(i: Int, v: Long): Long = {
			if (i >= 4)
				v
			else {
				val s = scala.io.StdIn.readLine().split(" ")
				val v2 = f(i, 0, s, v)
				g((i + 1), v2)
			}
		}
		new Puzzle(g(0, 0L))
	}
	val pz = inputPuzzle()
	val res = Solver.solve(pz)
}

