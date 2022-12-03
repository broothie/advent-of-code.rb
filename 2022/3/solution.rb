require 'pry'
require_relative "../../runner"

LOWERCASE = ('a'..'z').to_a
UPPERCASE = ('A'..'Z').to_a

part_1 example: 157 do |input|
  input
    .split("\n")
    .map { |rucksack| rucksack.chars.each_slice(rucksack.length / 2).map(&:join) }
    .map { |(compartment_1, compartment_2)| (compartment_1.chars & compartment_2.chars).first }
    .map { |char| LOWERCASE.include?(char) ? LOWERCASE.index(char) + 1 : UPPERCASE.index(char) + 27 }
    .sum
end

part_2 example: 70 do |input|
  input
    .split("\n")
    .each_slice(3)
    .map { |group| group.map(&:chars).reduce(:&).first }
    .map { |char| LOWERCASE.include?(char) ? LOWERCASE.index(char) + 1 : UPPERCASE.index(char) + 27 }
    .sum
end
