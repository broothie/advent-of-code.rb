require_relative "../../framework"

class Parser
  attr_reader :filesystem

  # @param input [String]
  # @return [Hash{String -> Integer}]
  def self.parse(input)
    parser = new(input)
    parser.parse!

    parser.filesystem
  end

  # @param input [String]
  def initialize(input)
    @input = input

    @index = 0
    @cwd = "/"
    @filesystem = { "/" => 0 }
  end

  # @return [void]
  def parse!
    parse_line! until done?
  end

  private

  # @param name [String]
  # @return [void]
  def mkdir(name)
    path = "#{File.join(@cwd, name)}"
    path += "/" unless path.end_with?("/")
    @filesystem[path] = 0

    path
  end

  # @param name [String]
  # @param size [Integer]
  def touch(name, size)
    path = "#{File.join(@cwd, name)}"
    @filesystem[path] = size

    path
  end

  # @return [void]
  def parse_line!
    case command
    when "cd" then parse_cd!
    when "ls" then parse_ls!
    else bail "invalid command"
    end
  end

  # @return [void]
  def parse_cd!
    case tokens[2]
    when "/"
      @cwd = "/"
    when ".."
      @cwd = File.split(@cwd).first unless @cwd == "/"
    else
      @cwd = mkdir(tokens[2])
    end

    advance!
  end

  # @return [void]
  def parse_ls!
    advance!

    until done? || command?
      if tokens[0] == "dir"
        mkdir(tokens[1])
      else
        touch(tokens[1], tokens[0].to_i)
      end

      advance!
    end
  end

  # @return [String]
  def command
    if command?
      tokens[1]
    else
      bail "not a command line"
    end
  end

  # @return [TrueClass, FalseClass]
  def command?
    tokens.first == "$"
  end

  # @return [TrueClass, FalseClass]
  def done?
    @index >= lines.length
  end

  # @return [void]
  def advance!
    @index += 1
  end

  # @return [Array<String>]
  def tokens
    line.split(/\s+/)
  end

  # @return [String]
  def line
    lines[@index]
  end

  # @return [Array<String>]
  def lines
    @lines ||= @input.split("\n")
  end

  def bail(message)
    abort <<~MSG
      error: #{message}
      #{index}| #{line}
    MSG
  end
end

part_1 example: 95437 do |input|
  fs = Parser.parse(input)

  fs
    .keys
    .select { |path| path.end_with?("/") }
    .map { |dir|
      fs
        .reject { |name, _| name.end_with?("/") }
        .select { |name, _| name.start_with?(dir) }
        .values
        .sum
    }
    .select { |dir_size| dir_size <= 100000 }
    .sum
end

part_2 example: 24933642 do |input|
  fs = Parser.parse(input)

  used = fs
    .reject { |name, _| name.end_with?("/") }
    .values
    .sum

  needed = used - (70000000 - 30000000)

  fs
    .keys
    .select { |path| path.end_with?("/") }
    .map { |dir|
      fs
        .reject { |name, _| name.end_with?("/") }
        .select { |name, _| name.start_with?(dir) }
        .values
        .sum
    }
    .select { |sum| sum >= needed }
    .sort
    .first
end
