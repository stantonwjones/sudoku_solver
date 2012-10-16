def get_available(puzzle, y, x)
  return [:immutable] if puzzle[y][x] != "0"
  ((1..9).to_a.map { |digit| digit.to_s } - puzzle.map { |col| col[x] }) & ((1..9).to_a.map { |digit| digit.to_s } - puzzle[y]) & (((1..9).to_a.map { |digit| digit.to_s }) - (puzzle[(((y / 3) * 3)..(((y / 3) * 3) + 2))].map { |row| row[(((x / 3) * 3)..(((x / 3) * 3) + 2))] }).flatten)
end

def solve(puzzle, y = 0, x = 0)
  available_guesses = get_available(puzzle, y, x)

  ########### DEBUG
  if available_guesses.empty? || available_guesses[0] == :immutable
    puts "no guesses available         at coord: #{y}, #{x}"
    puts
  else
    print "available guesses: " + available_guesses.join(' ')
    (9 - ((available_guesses.length * 2) - 1)).times { print " " }
    puts " at coord: #{y}, #{x}"
    puts
  end
  #############
  
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

solve(get_file)