require "rubygems"
require "rake"
require "active_record"
require File.dirname(__FILE__) + "/../lib/quick_mysql_import"

namespace :quick_mysql_dump do
  DB_ROOT_DIRECTORY = RAILS_ROOT + "/db/dumps"

  desc "Dump into db directory"
  task :dump do
    QuickMysqlImport::Dump.new(DB_ROOT_DIRECTORY).dump
  end
  
  desc "Import db dump.  Wipes out your current development database.  BEWARE!"
  task :import => ["db:drop", "db:create"] do
    dir_or_file = Dir.glob(DB_ROOT_DIRECTORY + "/*").sort.last
    dir_or_file = File.expand_path(dir_or_file)

    if dir_or_file.include?(".tar.gz")
      sh "tar -xvzf #{dir_or_file} -C #{DB_ROOT_DIRECTORY}"
      dir = dir_or_file.gsub(".tar.gz", "")
    else
      dir = dir_or_file
    end

    QuickMysqlImport::Import.new(dir).import
  end
end
