package sparkhail

object CreateOption {
  def stringNone() : Option[String] = None
  
  def int(i: Int) : Option[Int] = Some(i)
}

