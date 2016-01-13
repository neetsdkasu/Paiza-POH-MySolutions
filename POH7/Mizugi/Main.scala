/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
object Main extends App {
    
    def reject(v :Long, d :Long, c :Int) :(Long, Int) = {
        if (v % d == 0)
            reject(v / d, d, c + 1)
        else
            (v, c)
    }
    
    def conti(n :Long, r :Long, c :Int) :(Long, Int) = {
        if (n > 1) {
            val (x, c1) = reject(n, 5, 0)
            val (y, c2) = reject(x, 2, 0)
            val z = (r * y) % 1000000000
            conti(n - 1, z, c + c2 - c1)
        } else
            (r, c)
    }
    
    def multiple(v :Long, c :Int) :Long = {
        if (c == 0)
            v
        else
            multiple((v * 2) % 1000000000, c - 1)
    }
    
    def solve(n :Long) :Long = {
        val (r, c) = conti(n, 1, 0)
        multiple(r, c)
    }
    
    val n = scala.io.StdIn.readLine.toLong
    println(solve(n))
}
