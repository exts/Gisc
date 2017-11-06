require "./spec_helper"

include Gisc

describe Gisc do
  describe Image do
    it "should return false when file doesn't exist" do
      img = Image.new ""
      img.exists().should eq false
    end
  end

  describe Checker do
    it "should throw an FileMissingException if the file doesn't exist" do
      expect_raises(Exceptions::FileMissingException) do
        gisc = Checker.new ""
      end
    end

    it "should be a valid jpg" do
      gisc = Checker.new "spec/fixture/img.jpg"
      gisc.check("jpg").should eq true
    end

    it "should be a valid jpg, regardless of it's file type" do
      gisc = Checker.new "spec/fixture/img.png"
      gisc.check("jpg").should eq true
    end

    it "should throw a SignatureMissingException" do
      expect_raises(SignatureMissingException) do
        gisc = Checker.new "spec/fixture/fake.txt"
      end
    end
  end
  
end
