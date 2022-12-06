require_relative "../../framework"

MOVE_REGEX = /move (\d+) from (\d+) to (\d+)/.freeze

# @param crates_input [String]
# @return [Array<Array<String>>]
def parse_crates_input(crates_input)
  crates_input_lines = crates_input.split("\n")
  crate_stacks_count = crates_input_lines
    .pop
    .split(/\s+/)
    .map(&:to_i)
    .max

  crates = Array.new(crate_stacks_count) { [] }
  crates_input_lines.each do |line|
    line.chars.each_slice(4).with_index do |crate_chars, index|
      crate = crate_chars.join.gsub(/\W/, "")
      crates[index].prepend(crate) unless crate.empty?
    end
  end

  crates
end

part_1 example: "CMZ" do |input|
  crates_input, moves_input = input.split("\n\n")

  crates = parse_crates_input(crates_input)
  moves_input
    .split("\n")
    .map { |line| MOVE_REGEX.match(line).captures.map(&:to_i) }
    .each { |(count, from, to)| count.times { crates[to - 1] << crates[from - 1].pop } }

  crates.map(&:last).join
end

part_2 example: "MCD" do |input|
  crates_input, moves_input = input.split("\n\n")

  crates = parse_crates_input(crates_input)
  moves_input
    .split("\n")
    .map { |line| MOVE_REGEX.match(line).captures.map(&:to_i) }
    .each { |(count, from, to)| crates[to - 1] += crates[from - 1].pop(count) }

  crates.map(&:last).join
end
