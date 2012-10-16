def get_available(puzzle, y, x)
  # find the union of 3 sets:
  # the column, the row, and lastly:
  # for each member of values matrix within the region spanning from the truncated values
  # of y/3, x/3 to y/3 + 2, x/3 + 2, which form a given 9-box cell of the sudoku puzzle,
  # read the appropriate value, and subtract the results from a char array of the digits
  # 0 through 9, thus reporting only the values not already used in the cell
  
  # hard to read, I know, but it was fun to make
  
  # would split this line better if I knew a way to do so in ruby
  ((1..9).to_a.map { |digit| digit.to_s } - puzzle.map { |col| col[x] }) & ((1..9).to_a.map { |digit| digit.to_s } - puzzle[y]) & (((1..9).to_a.map { |digit| digit.to_s }) - (puzzle[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map { |row| row[(((x / 3) * 3)..(((x / 3) * 3) + 2))] }).flatten)
end

def solve(puzzle, y = 0, x = 0)
  tries = puzzle.get_available(y, x)
  
  # if unable to proceed, backtrack
  return if tries.empty? && (y != 8 && x != 8)
  # if at the end, print and quit
  if y == 8 && x == 8
    puzzle[y][x] = tries[0]
    show(puzzle)
    exit
  end
  
  next_y = y
  next_x = x
  
  # if this spot is mutable, try to solve it with each possible value
  if ! (puzzle[y][x] == "0")
    tries.each do |box_val|
      puzzle[y][x] = box_val

      # if at end of row, go to beginning of next row
      if x == 8
        puts "row end"
        next_x = 0
        next_y += 1
      # otherwise move forward one spot in the row
      else
        next_x += 1
      end
      
      # now attempt to solve from here
      solve(puzzle, next_y, next_x)
    end
  end
  
  # moving forward if on an immutable space
  
  # if at end of row, go to beginning of next row
  if x == 8
    puts "row end"
    next_x = 0
    next_y += 1
  # otherwise move forward one spot in the row
  else
    next_x += 1
  end
  
  solve(puzzle, next_y, next_x)
end

def show(puzzle)
  puzzle.each do |line|
    puts line.join(" ")
  end
end

def get_file
  print "input puzzle name or 'exit': "
  user_in = gets.chomp
  exit if user_in == 'exit'
  puzzle_arr = []
  
  File.open("./puzzles/#{user_in}", "r") do |file|
    line_num = 0
    
    file.each do |line|
      this_line_arr = line.scan(/\d/)
      puzzle_arr.push this_line_arr
      
      raise "improper puzzle dimensions" if this_line_arr.length != 9
    end
  end
  
  puzzle_arr
end

while true
  solve(get_file)
end