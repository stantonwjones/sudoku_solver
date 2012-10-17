def get_available(puzzle, y, x) # The workings of this function should be clear as day
  {:vals => get_col(x) & get_row(y) & get_cell(y, x), :puzzle => puzzle, :y => y, :x => x}
end

def get_col(x)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle.map { |row| row[x] }
end

def get_row(y)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle[y]
end

def get_cell(y, x) # as you see, quite clear
  ((1..9).to_a.map do |digit|
    digit.to_s end) - (puzzle[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map do |col|
      col[(((x / 3) * 3)..(((x / 3) * 3) + 2))] end).flatten
end

def get_next_coord(moves_hash, steps_ahead = 1)
  return {:finished => true, :y => moves_hash[:y], :x => moves_hash[:x], :val => moves_hash[:puzzle][y][x]} if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][y][x] != "0"
  return {
  return {:finished => false, :puzzle => puzzle, :y => moves_hash[:y], :x => moves_hash[:x]} if moves_hash[:puzzle][y][x] != "0" && steps_ahead > 1
    
  elsif
  else
    get_next_coord(get_available(puzzle, 9 / (moves_hash[:y] + moves_hash[:x] + steps_ahead), (moves_hash[:y] + moves_hash[:x] + steps_ahead) % 9), steps_ahead + 1)
  end
end

def get_next_move(puzzle, y, x)
  {:val => , :y => , :x => }
end

def solve(puzzle_in, y = 0, x = 0)
  next_move = get_next_move(get_next_coord(get_available(puzzle, y, x)))
  
  show(puzzle, y + x)
  

  
  end
end

def show(puzzle, stack_level)
	(stack_level - 1).times { print "|  " }
  print "___" unless stack_level == 0
  puts "_________________"

  puzzle.each do |line|
	stack_level.times { print "|  " }
    puts line.join(" ")
  end
end

def get_file
  puzzle_arr = []
  
  File.open("./puzzles/#{gets.chomp}", "r") do |file|
    line_num = 0
    
    file.each do |line|
      this_line_arr = line.scan(/\d/)
      puzzle_arr.push this_line_arr
      
      raise "improper puzzle dimensions" if this_line_arr.length != 9
    end
  end
  
  puzzle_arr
end

solve(get_next_move(get_next_coord(get_available(get_file, 0, 0))))