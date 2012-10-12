class Puzzle
  @values = []
  @immutables = Array.new(9).map { |e| e = Array.new(9).map { |f| f = "false" } }
  
  def parse_immutables
    # Call after populating values, all non-zero values' coordinates are marked true in immutables
  end
  
  
end

class PuzzleReader
  
end