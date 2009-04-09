module QuickMysqlImport
  module MysqlConnection
    def mysql(string)
      mysql_connection.execute(string)
    end

    def mysqldump(string)
      "/usr/bin/env mysqldump #{string}"
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
