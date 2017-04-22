require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'colorize'
require 'csv'
require 'yaml'

REDEEMABLE_MAP = YAML::load(File.read(File.join(__dir__, 'redeemable.yml')))
CHOCOLATES     = YAML::load(File.read(File.join(__dir__, 'chocolates.yml')))

Dir["./lib/*.rb"].each {|file| require file }
