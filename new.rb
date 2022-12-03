#! env ruby
require 'fileutils'
require 'optionparser'

latest_year = Dir.glob("20??").sort.last.to_i
latest_day = File.basename(Dir.glob("#{latest_year}/*").last || "#{latest_year}/1").to_i

options = {
  year: latest_year,
  day: latest_day + 1,
}

OptionParser.new do |opts|
  opts.on("-y") { |y| options[:year] = y.to_i }
  opts.on("-d") { |d| options[:day] = d.to_i }
end.parse!

dir = "#{options[:year]}/#{options[:day]}"
puts FileUtils.mkdir_p(dir)
puts FileUtils.touch("#{dir}/input.txt")
puts FileUtils.touch("#{dir}/example.txt")
puts FileUtils.touch("#{dir}/solution.rb")
File.write("#{dir}/solution.rb", 'require_relative "../../runner"')
