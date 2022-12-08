require_relative "../../framework"

part_1 example: 21 do |input|
  grid = input
    .split("\n")
    .map { |line| line.chars.map(&:to_i) }

  height = grid.size
  width = grid.first.size

  count = 0
  grid.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      ups = (0...y).map { |y| [x, y] }
      downs = ((y + 1)...height).map { |y| [x, y] }
      lefts = (0...x).map { |x| [x, y] }
      rights = ((x + 1)...width).map { |x| [x, y] }

      is_visible = [ups, downs, lefts, rights]
        .any? { |pairs| pairs.all? { |(x, y)| tree > grid[y][x] } }

      count += 1 if is_visible
    end
  end

  count
end

part_2 example: 8 do |input|
  grid = input
    .split("\n")
    .map { |line| line.chars.map(&:to_i) }

  height = grid.size
  width = grid.first.size

  cores = []
  grid.each_with_index do |row, y|
    row.each_with_index do |tree, x|
      ups = (0...y)
        .to_a
        .reverse
        .slice_after { |y| tree <= grid[y][x] }
        .first
        &.count || 0

      downs = ((y + 1)...height)
        .slice_after { |y| tree <= grid[y][x] }
        .first
        &.count || 0

      lefts = (0...x)
        .to_a
        .reverse
        .slice_after { |x| tree <= grid[y][x] }
        .first
        &.count || 0

      rights = ((x + 1)...width)
        .slice_after { |x| tree <= grid[y][x] }
        .first
        &.count || 0

      cores << ups * downs * lefts * rights
    end
  end

  cores.max
end
