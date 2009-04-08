module QuickMysqlImport
  class FileFinder
    def initialize(dir)
      @dir = dir
    end

    def schema_file
      File.expand_path("#{@dir}/schema.sql")
    end

    def data_files
      Dir.glob("#{@dir}/*.tab").map do |file|
        File.expand_path(file)
      end
    end
  end
end
