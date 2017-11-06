module Gisc::Signatures
  class Jpeg < Gisc::Signature
    def type
      ["jpg", "jpeg"]
    end

    def mimetype
      "image/jpeg"
    end

    def matches(data : Slice) : Bool

      # these are the first and last few bytes of 
      # a jpeg file that we want to check
      start_bytes = ["ff", "d8"]
      end_bytes = ["ff", "d9"]

      # here we attempt to grab the first few and end bytes
      # from the actual image slice or return false if we can't get that data
      data_start = [] of String
      data_end = [] of String

      begin
        data[0, 2].each do |d|
          data_start << d.to_s(16)
        end

        data[data.bytesize-2, 2].each do |d|
          data_end << d.to_s(16)
        end
      rescue ex
        return false
      end

      # if the starting and ending few bytes don't match we need to handle this
      if start_bytes != data_start || end_bytes != data_end
        return false
      end
      
      # this is the file signature for common jpeg file types and we'll
      # attempt to compare those bytes w/ the image data to figure out
      # if the jpeg image matches our common signatures
      hex_sequence = [
        ["ff", "d8", "ff", "db"],
        ["ff", "d8", "ff", "e0"],
        ["ff", "d8", "ff", "e1"],
        ["ff", "d8", "ff", "e2"],
        ["ff", "d8", "ff", "e8"],
      ]

      if data.size < 4
        return false
      end

      hex_data = [] of String
      data[0, 4].each do |d|
        hex_data << d.to_s(16)
      end
      
      hex_sequence.each do |seq|
        if seq == hex_data
          return true
        end
      end

      false
    end
  end
end