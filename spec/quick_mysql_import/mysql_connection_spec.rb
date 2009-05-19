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

    describe "views" do
      def sql_execute(sql)
        ActiveRecord::Base.connection.execute(sql)
      end

      def drop_view(view_name)
        sql_execute "DROP VIEW IF EXISTS #{view_name}"
      end

      def use_view(view_name)
        drop_view(view_name)
        sql_execute "CREATE VIEW #{view_name} AS (select * from view_testing)"
        yield
      ensure
        drop_view(view_name)
      end

      it "should not show views" do
        use_view :foo do
          @obj.tables.should_not include("foo")
        end
      end
    end
  end
end
