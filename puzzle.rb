class Puzzle 
  def initialize(values, immutables)
    @values = values
    @immutables = immutables
  end
  
  def get_available(coord)
    
  end
  
  def get_col
    
  end
  
  def get_row
    
  end
  
  def get_cell
    
  end
end

def read_puzzle(file_name)
  def parse_immutables
    @immutables = Array.new(9).map { |e| e = Array.new(9).map { |f| f = "false" } }
    # Call after populating values, all non-zero values' coordinates are marked true in immutables
  end
end

def solve(puzzle)
  
end

while true
  print "enter puzzle name or 'exit': "
  user_in = gets.chomp
  if user_in == exit then exit end
  solve(read_puzzle("./puzzles/#{user_in}.txt"))
end