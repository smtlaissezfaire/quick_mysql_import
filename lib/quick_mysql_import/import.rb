module QuickMysqlImport
  class Import
    include MysqlConnection
    include Tableizer

    def initialize(dir, use_threading = false)
      @dir           = dir
      @use_threading = use_threading
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
        import = lambda { import_file(file) }

        if use_threading
          fork(&import)
        else
          import.call
        end
      end
    end

    def import_file(file)
      mysql "LOAD DATA IN FILE #{file} INTO TABLE #{tablize(file)}"
    end

    def use_threading?
      @use_threading ? true : false
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
