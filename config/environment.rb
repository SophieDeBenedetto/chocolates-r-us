require 'rubygems'
require 'bundler/setup'
require 'pry'
require 'colorize'
require 'csv'
require 'yaml'

ENV["chocolates_r_us_environment"] ||= "development"
input_path  = YAML::load(File.read(File.join(__dir__, 'input_dir.yml')))[ENV["chocolates_r_us_environment"]]["input_dir"]
output_path = YAML::load(File.read(File.join(__dir__, 'output_dir.yml')))[ENV["chocolates_r_us_environment"]]["output_dir"]
INPUT_DIR      = File.join(File.expand_path("./"), "#{input_path}")
OUTPUT_DIR     = File.join(File.expand_path("./"), "#{output_path}")

Dir["./lib/*.rb"].each {|file| require file }


