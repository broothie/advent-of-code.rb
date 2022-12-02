
# @param example [Integer]
# @param block [Proc]
# @return [void]
def part_1(example:, &block)
  part(1, example:, &block)
end

# @param example [Integer]
# @param block [Proc]
# @return [void]
def part_2(example:, &block)
  part(2, example:, &block)
end

# @param part [Integer]
# @param example [Integer]
# @param block [Proc]
# @return [void]
def part(part, example:, &block)
  day_dir = File.dirname(File.absolute_path(caller[1].split(":").first))

  example_output = block.call(File.read(File.join(day_dir, "example.txt")))
  abort "incorrect example in part #{part}: got #{example_output}, want #{example}" unless example_output == example

  puts "part #{part}: #{block.call(File.read(File.join(day_dir, "input.txt")))}"
end


