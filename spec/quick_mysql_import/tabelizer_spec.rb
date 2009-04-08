require File.dirname(__FILE__) + "/../spec_helper"

module QuickMysqlImport
  describe Tableizer do
    before do
      @obj = Object.new
      @obj.extend Tableizer
    end

    it "should keep 'foo_bar'" do
      @obj.tableize("foo_bar").should == "foo_bar"
    end

    it "should remove path info" do
      @obj.tableize("/foo/bar/foo_bar").should == "foo_bar"
    end

    it "should strip out the file extension" do
      @obj.tableize("foo_bar.tab").should == "foo_bar"
    end
  end
end
