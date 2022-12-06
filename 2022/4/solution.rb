require_relative "../../framework"

part_1 example: 2 do |input|
  input
    .split("\n")
    .map { |line| line.split(",").map { |section_assignment| Range.new(*section_assignment.split("-").map(&:to_i)) } }
    .count { |(assignment_a, assignment_b)| assignment_a.cover?(assignment_b) || assignment_b.cover?(assignment_a) }
end

part_2 example: 4 do |input|
  input
    .split("\n")
    .map { |line| line.split(",").map { |section_assignment| Range.new(*section_assignment.split("-").map(&:to_i)) } }
    .count { |(assignment_a, assignment_b)| (assignment_a.to_a & assignment_b.to_a).any? }
end
