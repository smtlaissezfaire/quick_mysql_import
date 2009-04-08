module QuickMysqlImport
  module MysqlConnection
    def mysql(string)
      ActiveRecord::Base.connection.execute(string)
    end

    def mysqldump(string)
      "/usr/bin/env mysqldump #{string}"
    end

    def mysql_user
      raise NotImplementedError
    end

    def mysql_password
      raise NotImplementedError
    end

    def mysql_host
      raise NotImplementedError
    end

    def mysql_database
      raise NotImplementedError
    end
  end
end
