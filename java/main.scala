package sparkhail

import org.apache.spark.rdd._
import org.apache.spark.sql._
import org.apache.spark.sql.catalyst.expressions._

object CreateOption {
  def stringNone() : Option[String] = None
  
  def int(i: Int) : Option[Int] = Some(i)
}

object HailConverter {
  def mtToRdd(rdd: RDD[GenericRow]) : RDD[Row] = {
    return rdd.map(x => Row(x.get(0).toString, "x.get(1)", "x.get(2)", "x.get(3)", "x.get(4)", "x.get(5)"))
  }
}
