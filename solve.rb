# Define a Grid data structure so that is clones itself deeply
class Grid < Array
    def clone
        Grid.new( self.map { |row| row.clone } )
    end
end

# The number of iterations
@@steps = 0

def get_available_guesses(puzzle, y, x)
  possibleColVals = get_col(puzzle, x)
  possibleRowVals = get_row(puzzle, y)
  possibleCellVals = get_cell(puzzle, y, x)
  possibleVals = possibleColVals & possibleRowVals & possibleCellVals
  {:vals => possibleVals,
   :puzzle => puzzle,
   :y => y,
   :x => x}
end

# Returns the unassigned values for this column of the puzzle
def get_col(puzzle, x)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle.map { |row| row[x] }
end

# Returns the unassigned values for this row of the puzzle
def get_row(puzzle, y)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle[y]
end

# Returns the unassigned values for the 3X3 cell the coordinates represent
def get_cell(puzzle, y, x)
  ((1..9).to_a.map { |digit| digit.to_s }) - (puzzle[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map do |col|
        col[(((x / 3) * 3)..(((x / 3) * 3) + 2))]
    end
  ).flatten
end

# for some reason the coord 0,0 and ONLY 0,0, and for EVERY puzzle produces can't convert nil into array at line 13 in '-'
def get_next_mutable_box( moves_hash, steps_ahead = 1 )
  @@steps += 1

  # clone the possible puzzle
  possiblePuzzle = moves_hash[:puzzle].clone

  # set the current values for x and y
  current_x = moves_hash[:x]
  current_y = moves_hash[:y]

  # If the value has already been assigned, it is the only possible value
  # for this location in the grid
  if possiblePuzzle[current_y][current_x] != "0"
    moves_hash[:vals] = [possiblePuzzle[current_y][current_x]]
  end

  # Make sure there are possible values for this location
  return unless moves_hash[:vals] && moves_hash[:vals].length > 0

  # Check for end state
  if current_x == 8 && current_y == 8
    # We have found a solution if we have assigned a value to every grid
    # location and there exists a possible value for the last space
    possiblePuzzle[current_y][current_x] = moves_hash[:vals][0]
    puts "\n:::SOLUTION FOUND:::\n"
    pretty_print( possiblePuzzle )
    puts "\n:::NUM STEPS: " + @@steps.to_s + "\n"
    exit
  end

  # get the next value for x and y
  next_x = current_x >=8 ? 0 : current_x + 1
  next_y = current_x >=8 ? current_y + 1 : current_y

  # Call this function recursively for all possible values at this location
  moves_hash[:vals].each do |possibleVal|
    nextPuzzleState = possiblePuzzle#.clone

    # tentatively set the value of this location in the grid and continue
    # iterating through possible states on the possible puzzle
    nextPuzzleState[current_y][current_x] = possibleVal
    get_next_mutable_box(get_available_guesses(nextPuzzleState, next_y, next_x), steps_ahead + 1)
  end

  # If none of the child states are valid, return false
  return false

end

def search_for_solution( puzzle, coord )
  #pretty_print(puzzle)

end

# Print a puzzle nicely
def pretty_print( puzzle )
  puzzle.each do |line|
    puts line.join(" ")
  end
end

def get_puzzle_from_file(puzzle_name)
  File.open("./puzzles/#{puzzle_name}", "r") do |file|
    rows = Grid.new(9)
    rows.each_index do |index|
        # Store each row as an array of characters ( strings of length 1 in ruby )
        rows[index] = file.gets.chomp.split('')
    end
    # return the populated puzzle values as a Grid object instance
    return rows
  end
end

#search_for_solution(get_next_mutable_box(get_available(get_puzzle_from_file, 0, 0)), 0, 0)
print "input file name: "
puzzle_from_file = get_puzzle_from_file(gets.chomp)
# we now only call get_next_mutable_box once.  Should still terminate with
# correct puzzle solution
get_next_mutable_box( get_available_guesses(puzzle_from_file, 0, 0) )

# If a puzzle solution is not found, print and exit
puts "No Solution Found for the puzzle"
exit