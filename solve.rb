def get_available_guesses(puzzle, y, x)
  {:vals => get_col(puzzle, x) & get_row(puzzle, y) & get_cell(puzzle, y, x), :puzzle => puzzle, :y => y, :x => x}
end

def get_col(puzzle, x)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle.map { |row| row[x] }
end

def get_row(puzzle, y)
  (1..9).to_a.map { |digit| digit.to_s } - puzzle[y]
end

def get_cell(puzzle, y, x)
  ((1..9).to_a.map do |digit|
    digit.to_s end) - (puzzle[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map do |col|
      col[(((x / 3) * 3)..(((x / 3) * 3) + 2))] end).flatten
end

# for some reason the coord 0,0 and ONLY 0,0, and for EVERY puzzle produces can't convert nil into array at line 13 in '-'
def get_next_mutable_box(moves_hash, steps_ahead = 1)
  # ensure taking at least one step ahead, skipping immutable values, alert if finished
  print "Hello"
  return {:finished => true, :puzzle => moves_hash[:puzzle], :val => moves_hash[:puzzle][8][8]} if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][8][8] != "0"
  print ", world."
  return {:finished => true, :puzzle => moves_hash[:puzzle], :val => moves_hash[:vals][0]} if moves_hash[:y] == 8 && moves_hash[:x] == 8 && moves_hash[:puzzle][8][8] == "0"
  print "  Spider"
  return {:finished => false, :puzzle => moves_hash[:puzzle], :y => moves_hash[:y], :x => moves_hash[:x]} if moves_hash[:puzzle][moves_hash[:y]][moves_hash[:x]] != "0" && steps_ahead > 1
  puts " war."
  
  # Error is here?
  get_next_mutable_box(get_available(moves_hash[:puzzle], 9 / (moves_hash[:y] + moves_hash[:x] + 1), (moves_hash[:y] + moves_hash[:x] + 1) % 9), steps_ahead + 1)
end

def search_for_solution(puzzle, coord)
  #pretty_print(puzzle)
  
end

def pretty_print(puzzle)
  puzzle.each do |line|
    puts line.join(" ")
  end
end

def get_puzzle_from_file(puzzle_name)  
  File.open("./puzzles/#{puzzle_name}", "r") do |file|
    return Array.new(9).map do |element|
      file.gets.scan(/\d/)
    end
  end
end

#search_for_solution(get_next_mutable_box(get_available(get_puzzle_from_file, 0, 0)), 0, 0)
print "input file name: "
(0..8).each do |y| (0..8).each do |x| get_next_mutable_box(get_available(get_puzzle_from_file(gets.chomp), y, x)) end end