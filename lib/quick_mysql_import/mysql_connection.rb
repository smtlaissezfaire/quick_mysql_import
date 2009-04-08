module QuickMysqlImport
  module MysqlConnection
    def mysql(string)
      ActiveRecord::Base.connection.execute(string)
    end
  end
end
