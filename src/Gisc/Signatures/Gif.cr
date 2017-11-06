module Gisc::Signatures
  class Gif < Gisc::Signature
    def type
      ["gif"]
    end
    def mimetype
      "image/gif"
    end

    def matches(slice : Slice) : Bool
      start_hexes = [
        ["47", "49", "46", "38", "37", "61"],
        ["47", "49", "46", "38", "39", "61"],
      ]

      if slice.bytesize < 6
        return false
      end

      slice_hex = [] of String
      slice[0, 6].each do |d|
        slice_hex << d.to_s(16)
      end

      start_hexes.each do |hex|
        if hex == slice_hex
          return true
        end
      end

      false
    end
  end
end