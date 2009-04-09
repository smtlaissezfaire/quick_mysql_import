module QuickMysqlImport
  class Dump
    include MysqlConnection

    def initialize(destination, temp_dir = "/tmp", use_threading = false)
      @destination   = File.expand_path(destination)
      @temp_dir      = File.expand_path(temp_dir)
      @time          = Time.now.strftime("%Y-%M-%d-%H-%M-%S")
      @use_threading = use_threading
    end
    
    attr_reader :destination

    def dump
      create_tmp_data_dir
      dump_schema
      dump_data
      move_data
      tar_and_compress_data
      final_file_name
    end

    def dump_schema
      mysqldump "#{mysql_options} > #{tmp_schema_path}"
    end
    
    def dump_data
      tables.each do |table|
        dump_data_from_table(table)
      end
    end
    
    def use_threading?
      @use_threading ? true : false
    end
    
    def dump_data_from_table(table_name)
      action = lambda do |table_name, outfile|
        mysql "SELECT * FROM `#{table_name}` INTO OUTFILE '#{outfile}'"
      end
      
      if use_threading?
        Thread.new(table_name, temp_outfile(table_name), &action)
      else
        action.call(table_name, temp_outfile(table_name))
      end
    end

    def move_data
      mv base_tmp_path, destination
    end

    def tar_and_compress_data
      tar
      compress
      remove_old_dir
    end

    def tar
      sh "tar -c #{new_path} > #{new_path}.tar"
    end

    def compress
      sh "gzip -9 #{new_path}.tar"
    end

    def final_file_name
      "#{new_path}.tar.gz"
    end

  private
  
    def remove_old_dir
      sh "rm -rf #{new_path}"
    end
  
    def create_tmp_data_dir
      sh "mkdir #{base_tmp_path}"
      sh "chmod 777 #{base_tmp_path}"
    end
  
    def temp_outfile(table_name)
      "#{base_tmp_path}/#{table_name}.tab"
    end

    def new_path
      "#{destination}/#{@time}"
    end

    def tmp_schema_path
      "#{base_tmp_path}/schema.sql"
    end

    def base_tmp_path
      File.expand_path("#{@temp_dir}/#{@time}")
    end

    def mysql_options
      options = [
        "--no-data",
        "--single-transaction",
        "-u #{mysql_user}",
        "-h '#{mysql_host}'",
      ]
      
      options << "-p '#{mysql_password}'" if mysql_password
      options << "#{mysql_database}"
      
      options.join(" ")
    end
  end
end
