require "rake"

module QuickMysqlImport
  module MysqlConnection
    def mysql(string)
      mysql_connection.execute(string)
    end

    def mysqldump(string)
      sh "/usr/bin/env mysqldump #{string}"
    end

    def mysql_user
      mysql_config[:user]
    end

    def mysql_password
      mysql_config[:password]
    end

    def mysql_host
      mysql_config[:host]
    end

    def mysql_database
      mysql_config[:database]
    end
    
    def tables
      result = mysql "SHOW TABLES"
      result.extend Enumerable
      tables = result.to_a
      tables.flatten
    end
    
  private
  
    def mysql_config
      mysql_connection.config
    end
    
    def mysql_connection
      @connection ||= begin
        connection = ActiveRecord::Base.connection
        # See https://rails.lighthouseapp.com/projects/8994/tickets/2464-patch-allow-mysqladapterconfig-accessible
        class << connection
          attr_reader :config
        end
        
        connection
      end
    end
  end
end
