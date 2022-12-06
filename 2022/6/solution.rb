require_relative "../../framework"

part_1 example: 7 do |input|
  4 + input
    .chars
    .each_cons(4)
    .find_index { |chars| chars == chars.uniq }
end

part_2 example: 19 do |input|
  14 + input
    .chars
    .each_cons(14)
    .find_index { |chars| chars == chars.uniq }
end
