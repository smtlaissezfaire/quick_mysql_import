module QuickMysqlImport
  class Dump
    include MysqlConnection

    def initialize(destination, temp_dir = "/tmp")
      @dir           = File.expand_path(destination)
      @time          = Time.now
      @use_threading = use_threading
    end

    def dump
      dump_schema
      dump_data
      move_data
      tar_and_compress_data
      final_file_name
    end

    def dump_schema
      mysqldump "#{mysql_options} > #{temp_schema_path}"
    end

    def dump_data
      mysql "SELECT * FROM #{table_name} INTO OUTFILE #{temp_outfile(table_name)}"
    end

    def move_data
      mv base_tmp_path, destination
    end

    def tar_and_compress
      tar
      compress
    end

    def tar
      sh "tar -c #{new_path} > #{new_path}.tar"
    end

    def compress
      sh "gzip -9 #{new_path}.tar"
    end

    def final_file_name
      "#{@dir}/#{new_path}.tar.gz"
    end

  private

    def new_path
      "#{destination}/#{@time}"
    end

    def temp_schema_path
      "#{base_tmp_path}/schema.sql"
    end

    def base_tmp_path
      File.expand_path("#{temp_dir}/#{@time}")
    end

    def mysql_options
      [
        "--no-data",
        "-u #{mysql_user}",
        "-p '#{mysql_password}",
        "-h #{mysql_host}",
        "#{mysql_database}" # db
      ].join(" ")
    end
  end
end
