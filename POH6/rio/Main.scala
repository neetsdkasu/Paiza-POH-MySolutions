/*
 * 結果 https://paiza.jp/poh/joshibato/rio/result/c24a94c3
 */
object Main extends App{
    
    def solve(n: Int, water: Double, coffee: Double): Unit = {
        if (n == 0) {
            val ans = 100.0 * coffee / (water + coffee);
            println(ans.intValue());
        } else {
            val tas = scala.io.StdIn.readLine().split(" ")
            val s = tas(1).toDouble
            tas(0) match {
            case "1" => solve(n - 1, water + s, coffee)
            case "2" => solve(n - 1, water, coffee + s)
            case  _  => val wc = water + coffee
                        solve(n - 1, (water * wc - s * water) / wc, (coffee * wc - s * coffee) /  wc)
            }
        }
    }
    
    val n = scala.io.StdIn.readLine().toInt
    
    solve(n, 0.0, 0.0)
}
