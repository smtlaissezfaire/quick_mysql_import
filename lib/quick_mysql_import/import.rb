module QuickMysqlImport
  class Import
    include MysqlConnection
    include Tableizer

    def initialize(dir, use_threading = false)
      @dir           = dir
      @use_threading = use_threading
    end

    def import
      import_schema
      import_data
    end

    def import_schema
      puts "* Importing schema"
      options_string = build_options("-e 'source #{schema_file}'")
      `mysql #{options_string}`
    end

    def import_data
      data_files.each do |file|
        import = lambda do
          puts "* Importing file #{file}"
          import_file(file)
        end
        
        use_threading? ? fork(&import) : import.call
      end
    end

    def import_file(file)
      table_name = File.basename(file)
      table_name = table_name.gsub!(".tab", "")
      mysql "LOAD DATA LOCAL INFILE '#{file}' INTO TABLE #{table_name}"
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
