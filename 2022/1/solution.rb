require_relative "../../framework"

part_1 example: 24000 do |input|
  input
    .split("\n\n")
    .map { |group| group.split("\n").map(&:to_i).sum }
    .max
end

part_2 example: 45000 do |input|
  input
    .split("\n\n")
    .map { |group| group.split("\n").map(&:to_i).sum }
    .max(3)
    .sum
end
