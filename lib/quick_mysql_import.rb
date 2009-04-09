
require "using"

module QuickMysqlImport
  extend Using
  
  Using.default_load_scheme = :load
  
  using :FileFinder
  using :MysqlConnection
  using :Tableizer
  using :Import
  using :Dump
  using :Version

  VERSION = Version::STRING
end
