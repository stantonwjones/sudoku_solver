class Puzzle 
  def initialize(values, immutables)
    @values = values
    @immutables = immutables
  end
  
  def get_available(y, x)
    get_col() & get_row() & get_cell
  end
  
  def get_col
    
  end
  
  def get_row
    
  end
  
  def get_cell
    
  end
end

def solve(puzzle)
  
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