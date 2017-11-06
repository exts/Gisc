module Gisc
  abstract class Signature
    abstract def type : Array(String)
    abstract def mimetype : String
    abstract def matches(data : Slice) : Bool
  end
end