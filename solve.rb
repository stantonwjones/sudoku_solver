##### all these work
def get_available(puzzle, y, x) # The workings of this function should be clear as day
  show(puzzle)
  {:vals => get_col(puzzle, x) & get_row(puzzle, y) & get_cell(puzzle, y, x), :puzzle => puzzle, :y => y, :x => x}
end

def get_col(puzzle, x)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle.map { |row| row[x] }
end

def get_row(puzzle, y)
  #puts puzzle[y]
  (1..9).to_a.map { |digit| digit.to_s } - puzzle[y]
end

def get_cell(puzzle, y, x) # as you see, quite clear
  ((1..9).to_a.map do |digit|
    digit.to_s end) - (puzzle[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map do |col|
      col[(((x / 3) * 3)..(((x / 3) * 3) + 2))] end).flatten
end
#####

# for some reason the coord 0,0 and ONLY 0,0, and for EVERY puzzle produces can't convert nil into array at line 13 in '-'
def get_next_move(moves_hash, steps_ahead = 1) # do you see?  DO YOU SEE?  http://www.southparkstudios.com/clips/103836/do-you-see
  # ensure taking at least one step ahead, skipping immutable values, alert if finished
  print "Hello"
  return {:finished => true, :puzzle => moves_hash[:puzzle], :val => moves_hash[:puzzle][8][8]} if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][8][8] != "0"
  print ", world."
  return {:finished => true, :puzzle => moves_hash[:puzzle], :val => moves_hash[:vals][0]} if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][8][8] == "0"
  print "  Spider"
  return {:finished => false, :puzzle => moves_hash[:puzzle], :y => moves_hash[:y], :x => moves_hash[:x]} if moves_hash[:puzzle][moves_hash[:y]][moves_hash[:x]] != "0" && steps_ahead > 1
  puts " war."
  
  # Error is here?
  get_next_move(get_available(moves_hash[:puzzle], 9 / (moves_hash[:y] + moves_hash[:x] + 1), (moves_hash[:y] + moves_hash[:x] + 1) % 9), steps_ahead + 1)
end

def solve(next_move, y, x)
  if next_move[:finished] then next_move[:puzzle][8][8] = next_move[:val]; show next_move[:puzzle]; exit end
  
  solve(get_next_move(get_available(puzzle, y, x)))
end

def show(puzzle)
  puzzle.each do |line|
    puts line.join(" ")
  end
end

def get_file
  print "input file name: "
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

#solve(get_next_move(get_available(get_file, 0, 0)), 0, 0)
(0..8).each do |y| (0..8).each do |x| get_next_move(get_available(get_file, y, x)) end end