module QuickMysqlImport
  class Import
    include MysqlConnection
    include Tableizer

    def initialize(dir)
      @dir = dir
    end

    def import
      drop_database
      import_schema
      import_data
    end

    def drop_database
      mysql "DROP DATABASE #{database_name}"
    end

    def import_schema
      mysql "source #{schema_file}"
    end

    def import_data
      data_files.each do |file|
        import_file(file)
      end
    end

    def import_file(file)
      mysql "LOAD DATA IN FILE #{file} INTO TABLE #{tablize(file)}"
    end

  private

    def schema_file
      file_finder.schema_file
    end

    def data_files
      file_finder.data_files
    end

    def file_finder
      @file_finder ||= FileFinder.new(@dir)
    end
  end
end
