
require "using"

class Module
  include Using
end

module QuickMysqlImport
  using :FileFinder
  using :MysqlConnection
  using :Tableizer
  using :Import
  using :Version

  VERSION = Version::STRING
end
