require File.dirname(__FILE__) + "/../spec_helper"

describe QuickMysqlImport do
  it "should be at version 0.0.1" do
    QuickMysqlImport::VERSION.should == "0.0.1"
  end
end
