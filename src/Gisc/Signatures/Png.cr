module Gisc::Signatures
  class Png < Gisc::Signature
    def type
      ["png"]
    end

    def mimetype
      "image/png"
    end

    def matches(slice : Slice) : Bool
      start_hex = ["89", "50", "4e", "47", "d", "a", "1a", "a"]

      if slice.bytesize < 8
        return false
      end

      slice_hex = [] of String

      slice[0, 8].each do |d|
        slice_hex << d.to_s(16)
      end

      if start_hex != slice_hex
        false
      else
        true
      end
    end
  end
end