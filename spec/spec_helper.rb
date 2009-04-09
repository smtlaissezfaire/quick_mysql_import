require "rubygems"
require "spec"

require 'sqlite3'
require 'active_record'
require 'active_support'

ActiveRecord::Base.establish_connection :adapter => 'mysql', :database  => 'quick_mysql_dump'

require File.dirname(__FILE__) + "/../lib/quick_mysql_import"

