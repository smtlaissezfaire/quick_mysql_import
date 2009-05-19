require "rubygems"
require "spec"

require 'sqlite3'
require 'active_record'
require 'active_support'

ActiveRecord::Base.establish_connection :adapter => 'mysql', :database  => 'quick_mysql_dump'

require File.dirname(__FILE__) + "/../lib/quick_mysql_import"

ActiveRecord::Schema.define do
  create_table :view_testing, :force => true do |t|
    t.timestamps
  end
end
