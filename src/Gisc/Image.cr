module Gisc
  class Image
    @data : String = ""
    @data_bytes = [] of Bytes

    def initialize(@filename : String)
    end

    def exists
      File.file?(@filename)
    end

    def load
      @data = File.read(@filename) if self.exists
    end

    def get
      @data
    end

    def getBytes
      @data.to_slice
    end
  end
end