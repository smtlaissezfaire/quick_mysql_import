module QuickMysqlImport
  module Tableizer
    def tableize(string)
      str = File.basename(string)
      str.gsub!(File.extname(str), "")
      str
    end
  end
end
