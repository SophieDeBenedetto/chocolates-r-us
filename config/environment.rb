require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'csv'

Dir["./lib/*.rb"].each {|file| require file }
