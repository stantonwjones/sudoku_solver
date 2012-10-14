# TODO: heuristics, modular cell-value checker, recursive solver itself

class Puzzle
  attr_accessor :values_matrix
  
  def initialize(values_matrix, immutables)
    @values_matrix = values_matrix
    @immutables = immutables
  end
  
  def get_available(y, x)
    return if @immutables.include? [y, x]

    get_col(x) & get_row(y) & get_cell(y, x)
  end
  
  def get_col(x)
    
    
    # just get the x-th element of each row
    (0..9).to_a.map { |digit| digit.to_s } - @values_matrix.map { |col| col = col[x] }
  end
  
  def get_row(y)
    
    (0..9).to_a.map { |digit| digit.to_s } - @values_matrix[y]
  end
  
  def get_cell(y, x)
    
    (0..9).to_a.map { |digit| digit.to_s } - cell_vals
  end
end

def solve(puzzle) # (, coord)
  puzzle.get_available
end

def show(puzzle)
  puzzle.each do |line|
    puts line.join(" ")
  end
end

while true
  puts "input puzzle name: "
  user_in = gets.chomp
  exit if user_in == 'exit'
  puzzle = nil
  
  # throw exception if puzzle not 9 x 9
  
  File.open(".puzzles/#{user_in}", "r") do |file|
    line_num = 0
    puzzle_arr = []
    immutables = []
    
    file.each do |line|
      this_line_arr = line.scan(/\d/)
      puzzle_arr.push this_line_arr
      
      this_line_arr.each_with_index do |char, char_index|
        immutables.push [line_num, char_index] if char != "0" 
      end
      
      line_num += 1
    end
    
    puzzle = Puzzle.new(puzzle_arr, immutables) 
  end
  
  solve puzzle
end