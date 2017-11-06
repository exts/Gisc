module Gisc::Signatures
  include Gisc::Exceptions
  
  class SignatureFactory
    getter signature

    def self.create(current_type : String) : Gisc::Signature
      case current_type
      when "jpeg", "jpg"
        return Signatures::Jpeg.new
      when "gif"
        return Signatures::Gif.new
      when "png"
        return Signatures::Png.new
      else
        raise SignatureMissingException.new "Image Signature doesn't exist"
      end
    end

    def self.getSignatures : Array(Gisc::Signature)
      [
        SignatureFactory.create("png"),
        SignatureFactory.create("gif"),
        SignatureFactory.create("jpeg"),
      ]
    end
  end
end