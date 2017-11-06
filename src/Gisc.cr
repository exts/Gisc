require "./Gisc/*"
require "./Gisc/Signatures/*"

module Gisc
  include Gisc::Exceptions
  include Gisc::Signatures

  class Checker
    getter image
    @signature : Gisc::Signature?
    
    def initialize(@filename : String)

      # attempt to load image and throw an exception if the image doesn't exist
      @image = Image.new @filename

      if !@image.exists
        raise FileMissingException.new "Image file doesn't exist"
      end

      @image.load

      # assign signature if one exists
      self.get
    end

    # Attempt to check image signature & store matching signature
    protected def get
      signatures = SignatureFactory.getSignatures()
      signatures.each do |sig|
        if sig.matches @image.getBytes
          @signature = sig
        end
      end

      if @signature.nil?
        raise SignatureMissingException.new "Signature not found"
      end
    end

    # Used to make sure the passing image is the signature that we're
    # expecting it to be. So if an image has a .png extension, but isn't
    # a png, but rather a jpeg we can know that it isn't a png
    # 
    # ```
    # gisc.check("png") => false
    # ```
    def check(img_type : String) : Bool
      @signature.try do |sig|
        if sig.type.includes?(img_type)
          return true
        end
      end

      false
    end

    def signature : Gisc::Signature
      @signature.as(Gisc::Signature)
    end
  end
end
