require "rubygems"
require "rake"
require "active_record"
require File.dirname(__FILE__) + "/../lib/quick_mysql_import"

namespace :quick_mysql_dump do
  desc "Dump into db directory"
  task :dump do
    QuickMysqlImport::Dump.new(RAILS_ROOT + "/db/dumps").dump
  end
  
  desc "Import db dump.  Wipes out your current development database.  BEWARE!"
  task :import => ["db:drop", "db:create"] do
    QuickMysqlImport::Import.new(RAILS_ROOT + "/db/2009-12-08-17-12-21").import
  end
end
