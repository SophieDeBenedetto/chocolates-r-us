require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'colorize'
require 'csv'
require 'yaml'

ENV["chocolates_r_us_environment"] ||= "development"

REDEEMABLE_MAP = YAML::load(File.read(File.join(__dir__, 'redeemable.yml')))
CHOCOLATES     = YAML::load(File.read(File.join(__dir__, 'chocolates.yml')))
INPUT_DIR      = YAML::load(File.read(File.join(__dir__, 'input_dir.yml')))[ENV["chocolates_r_us_environment"]]["input_dir"]
OUTPUT_DIR     = YAML::load(File.read(File.join(__dir__, 'output_dir.yml')))[ENV["chocolates_r_us_environment"]]["output_dir"]

Dir["./lib/*.rb"].each {|file| require file }
