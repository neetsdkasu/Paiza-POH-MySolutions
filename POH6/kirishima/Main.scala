/*
 * 結果 https://paiza.jp/poh/joshibato/kirishima/result/e43bf36e
 */
object Main extends App {
    val readLine = () => scala.io.StdIn.readLine()
    
    def simulation(d: Int, tf: List[Int], tb: List[Int]): String = {
        if (d < 0) {
            if (tf.isEmpty) "No" else simulation(d + 1, tf.tail, tf.head :: tb)
        } else if (d > 0) {
            if (tb.isEmpty) "No" else simulation(d - 1, tb.head :: tf, tb.tail)
        } else {
            if (tf.isEmpty || tb.isEmpty) {
                "No"
            } else {
                if (tb.tail.isEmpty) {
                    "Yes"
                } else {
                    if (tb.head == 0) "No" else simulation(tb.head, tf, 0::tb.tail)
                }
            }
        }
    }

    val n = readLine().toInt
    val t = readLine().split(' ').map((x: String) => x.toInt).toList
    val m = readLine().toInt
    
    for (i <- 1 to m) {
        val d = readLine().toInt
        println(simulation(d, List(), t))
    }
}
