/*
 * 結果 https://paiza.jp/poh/joshibato/tsubame/result/4d3f5f16
 */
object Main extends App{
    
    val n_str = scala.io.StdIn.readLine()
    
    val n = n_str.toInt
    val n1 = n_str.substring(1,2).toInt
    val n10 = n_str.substring(0,1).toInt
    val r = n + n1 + n10
    
    println(r)
}
