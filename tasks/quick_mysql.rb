require "rubygems"
require "rake"
require "active_record"
require File.dirname(__FILE__) + "/../lib/quick_mysql_import"

namespace :quick_mysql_dump do
  desc "Dump into db directory"
  task :dump do
    QuickMysqlImport::Dump.new(RAILS_ROOT + "/db").dump
  end
end