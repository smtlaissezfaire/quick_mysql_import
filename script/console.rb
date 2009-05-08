#!/usr/bin/env ruby

require "rubygems"

def reload!
  load(File.dirname(__FILE__) + "/../lib/quick_mysql_import.rb")
end

reload!
