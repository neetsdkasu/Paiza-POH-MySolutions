/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
object Main extends App {
    
    def gs() = scala.io.StdIn.readLine
    def gi() = gs.toInt
    def gss() = gs.split(' ')
    def gis() = gss.map( _.toInt )
    def ngt[T](n :Int, f: ()=>T) = (1 to n).map( (_) => f() )
    def ngs(n :Int) = ngt(n, gs)
    def ngi(n :Int) = ngt(n, gi)
    def ngss(n :Int) = ngt(n, gss)
    def ngis(n :Int) = ngt(n, gis)
    
    val n = gi
    val q = ngis(n)
    val m = gi
    val p = ngis(m)
   
    for (i <- 0 to n - m)
        for (j <- 0 to n - m)
            if ( (0 until m).flatMap( (y) => (0 until m).map( (x) => q(i+y)(j+x) == p(y)(x) ) ).reduce( _ & _ ) )
                Console.println(List(i, j).mkString(" "))

}
