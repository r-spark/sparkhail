package sparkhail

import org.apache.spark.SparkContext
import org.apache.spark.rdd._
import org.apache.spark.sql._
import org.apache.spark.sql.catalyst.expressions._
import org.apache.spark.sql.types._
import org.json4s._
import org.json4s.jackson.JsonMethods._

object CreateOption {
  def stringNone() : Option[String] = None
  
  def int(i: Int) : Option[Int] = Some(i)
}

object HailConverter {
  def mtToRdd(rdd: RDD[GenericRow]) : RDD[Row] = {
    return rdd.map(x => Row(x.get(0).toString, x.get(1), x.get(2), x.get(3), x.get(4), 
                            x.get(5), x.get(6)))
  }
  
  def entriesStruct() : StructField = {
    val struct = StructType(Array(
        StructField("Call", IntegerType, true),
        StructField("AD", ArrayType(IntegerType), true),
        StructField("DP", IntegerType, true),
        StructField("GQ", IntegerType, true),
        StructField("PL", ArrayType(IntegerType), true)
    ))
    
    StructField("entries", ArrayType(struct), true)
  }
}


