/* Try POH
 * author: Leonardone @ NEETSDKASU
 */
object Main extends App {
    
    def das(da :List[List[Int]], xs :List[Int], ys:List[Int]) : (List[Int], List[Int]) = {
        da match {
        case List() =>
            (xs.sorted, ys.sorted)
        case h :: t =>
            val d :: a :: _ = h
            if (d == 0)
                das(t, a :: xs, ys)
            else
                das(t, xs, a :: ys)
        }
    }
    
    def gis() :List[Int] = scala.io.StdIn.readLine.split(' ').map((x :String) => x.toInt).toList
    val x :: y :: z :: n :: _ = gis()
    val (xs, ys) = das((1 to n).map((_) => gis()).toList, List(0,x), List(0,y))
    val f = (ab :(Int, Int)) => { val (a, b) = ab; a - b }
    val xmin = xs.tail.zip(xs).map(f).min
    val ymin = ys.tail.zip(ys).map(f).min
    val ans = xmin * ymin * z
    println(ans)
}
