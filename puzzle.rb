class Puzzle
  attr_accessor :values_matrix
  attr_reader :immutables
  
  def initialize(values_matrix, immutables)
    @values_matrix = values_matrix
    @immutables = immutables
  end
  
  def get_available(y, x)
    get_col(x) & get_row(y) & get_cell(y, x)
  end
  
  def get_col(x)
    (1..9).to_a.map { |digit| digit.to_s } - @values_matrix.map { |col| col[x] }
  end
  
  def get_row(y)
    (1..9).to_a.map { |digit| digit.to_s } - @values_matrix[y]
  end
  
  def get_cell(y, x)
    # for each member of values matrix within the region spanning from the truncated values
    # of y/3, x/3 to y/3 + 2, x/3 + 2, which form a given 9-box cell of the sudoku puzzle,
    # read the appropriate value, and subtract the results from a char array of the digits
    # 0 through 9, thus reporting only the values not already used in the cell
    
    # hard to read, I know, but it was fun to make
    ((1..9).to_a.map { |digit| digit.to_s }) - (@values_matrix[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map { |stuff| stuff[(((x / 3) * 3)..(((x / 3) * 3) + 2))] }).flatten
  end
end

def solve(puzzle, y = 0, x = 0, stack = 0)
  tries = puzzle.get_available(y, x)
  puts stack if tries.empty?
  return if tries.empty?
  
  tries.each { |box_val| puzzle.values_matrix[y][x] = box_val } unless puzzle.immutables.include?([y, x])
  
  if y == 8 && x == 8
    show puzzle
    exit
  end
  
  if x == 8
    x = 0
    y += 1
  end
  
  x += 1
  stack += 1
  
  solve puzzle, y, x, stack
end

def show(puzzle)
  puzzle.values_matrix.each do |line|
    puts line.join(" ")
  end
end

while true
  print "input puzzle name: "
  user_in = gets.chomp
  exit if user_in == 'exit'
  puzzle_arr = []
  immutables = []
    
  File.open("./puzzles/#{user_in}", "r") do |file|
    line_num = 0
    
    file.each do |line|
      this_line_arr = line.scan(/\d/)
      puzzle_arr.push this_line_arr
      
      raise "improper puzzle dimensions" if this_line_arr.length != 9
      
      this_line_arr.each_with_index do |char, char_index|
        immutables.push [line_num, char_index] if char != "0" 
      end
      
      line_num += 1
    end
  end
  
  solve Puzzle.new(puzzle_arr, immutables)
end