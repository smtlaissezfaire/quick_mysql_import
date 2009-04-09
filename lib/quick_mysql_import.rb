
require "using"

module QuickMysqlImport
  extend Using
  
  using :FileFinder
  using :MysqlConnection
  using :Tableizer
  using :Import
  using :Version

  VERSION = Version::STRING
end
