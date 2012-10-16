def get_available(puzzle, y, x)
  return [:immutable] if puzzle[y][x] != "0"
  
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
  available_guesses = get_available(puzzle, y, x)
  
  return if available_guesses.empty?
  
  available_guesses.each do |box_value|
    puzzle[y][x] = box_value unless box_value == :immutable

    if y == 8 && x == 8
      show(puzzle)
      exit
    end
        
    if x == 8
      x = 0
      y += 1
    else
      x += 1
    end
    
    show(puzzle); puts ## DEBUG
    solve(puzzle, y, x)
  end
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

solve(get_file)