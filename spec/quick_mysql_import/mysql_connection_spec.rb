require File.dirname(__FILE__) + "/../spec_helper"

module QuickMysqlImport
  describe MysqlConnection do
    before do
      @obj = Object.new
      @obj.extend MysqlConnection
    end
    
    it "should have the mysql_user" do
      user = ActiveRecord::Base.connection.instance_variable_get("@config")[:username]
      @obj.mysql_user.should == user
    end
    
    it "should have the mysql_database" do
      db = ActiveRecord::Base.connection.instance_variable_get("@config")[:database]
      @obj.mysql_database.should == db
    end
    
    it "should have the mysql_host" do
      host = ActiveRecord::Base.connection.instance_variable_get("@config")[:hostname]
      @obj.mysql_host.should == host
    end
    
    it "should have the mysql_password" do
      password = ActiveRecord::Base.connection.instance_variable_get("@config")[:passwordname]
      @obj.mysql_password.should == password
    end
  end
end