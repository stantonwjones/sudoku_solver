require './grid.rb'
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
  # ensure taking at least one step ahead, skipping immutable values, alert if finished
=begin
  print "Hello"
  return {
    :finished => true,
    :puzzle => moves_hash[:puzzle],
    :val => moves_hash[:puzzle][8][8]
  } if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][8][8] != "0"

  print ", world."
  return {:finished => true,
    :puzzle => moves_hash[:puzzle],
    :val => moves_hash[:vals][0]
  } if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][8][8] == "0"

  print "  Spider"
  return {
    :finished => false,
    :puzzle => moves_hash[:puzzle],
    :y => moves_hash[:y], :x => moves_hash[:x]
  } if moves_hash[:puzzle][moves_hash[:y]][moves_hash[:x]] != "0" && steps_ahead > 1
  puts " war."
=end

  # clone the possible puzzle
  possiblePuzzle = moves_hash[:puzzle].clone
  #print "a possible state of the puzzle:\n"
  #pretty_print possiblePuzzle

  # set the current values for x and y
  current_x = moves_hash[:x]
  current_y = moves_hash[:y]

  if possiblePuzzle[current_y][current_x] != "0"
=begin
    puts "non-zero puzzle loc at: " +
        "row, " + current_y.to_s +
        "; column, " + current_x.to_s
    puts "the value is: " + possiblePuzzle[current_y][current_x]
=end
    moves_hash[:vals] = [possiblePuzzle[current_y][current_x]]
  else
=begin
    puts "the possible values for row " + current_y.to_s + ", col " + current_x.to_s
    puts moves_hash[:vals].to_s
=end
  end

  # Make sure there are possible values for this location
  return unless moves_hash[:vals] && moves_hash[:vals].length > 0

  # Check for end state
  if current_x == 8 && current_y == 8
    possiblePuzzle[current_y][current_x] = moves_hash[:vals][0]
    puts "\n:::SOLUTION FOUND:::\n"
    pretty_print( possiblePuzzle )
    exit
  end

  # get the next value for x and y
  next_x = current_x >=8 ? 0 : current_x + 1
  next_y = current_x >=8 ? current_y + 1 : current_y

  # Call this function recursively for all possible values at this location
  moves_hash[:vals].each do |possibleVal|
    nextPuzzleState = possiblePuzzle.clone
    if nextPuzzleState.class != Grid
        puts('cloning grid returned an array')
        exit
    end
    nextPuzzleState[current_y][current_x] = possibleVal
    get_next_mutable_box(get_available_guesses(nextPuzzleState, next_y, next_x), steps_ahead + 1)
  end

  # If none of the child states are valid, return false
  return false

  # call get_next_mutable_box on the next location going left-right, top-bottom
  # TODO: this is currently just getting the available guesses for each location.  However, we need to add a
  # way to test for a solved sudoku puzzle and exit the program
  #get_next_mutable_box(get_available_guesses(moves_hash[:puzzle], next_y, next_x), steps_ahead + 1)
end

def search_for_solution( puzzle, coord )
  #pretty_print(puzzle)

end

def pretty_print( puzzle )
  puzzle.each do |line|
    puts line.join(" ")
  end
end

def get_puzzle_from_file(puzzle_name)
  File.open("./puzzles/#{puzzle_name}", "r") do |file|
    rows = Grid.new(9)
    rows.each_index do |index|
        #row = file.gets.scan(/\d*/)
        # Store each row as an array of characters ( strings of length 1 in ruby )
        rows[index] = file.gets.chomp.split('')
    end
    return rows
  end
end

#search_for_solution(get_next_mutable_box(get_available(get_puzzle_from_file, 0, 0)), 0, 0)
print "input file name: "
puzzle_from_file = get_puzzle_from_file(gets.chomp)
=begin
(0..8).each do |y| (0..8).each do |x|
    get_next_mutable_box( get_available_guesses(puzzle_from_file.clone, y, x) )
end end
=end
get_next_mutable_box( get_available_guesses(puzzle_from_file, 0, 0) )
puts "No Solution Found for the puzzle"
exit