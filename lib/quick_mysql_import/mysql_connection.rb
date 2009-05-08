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
      mysql_config[:username]
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
    
    def common_mysql_options
      common_mysql_options = [
        "-u '#{mysql_user}'",
        "-h '#{mysql_host}'",
      ]
      common_mysql_options << "-p '#{mysql_password}'" if mysql_password
      common_mysql_options << "#{mysql_database}"
      common_mysql_options
    end
    
    def build_options(*options)
      my_options = options.dup
      my_options.concat(common_mysql_options)
      my_options.join(" ")
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
