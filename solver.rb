require 'puzzle'

def solve(puzzle)
  puzzle.each do |line|
    
  end
  
  show(puzzle)
end

def show(puzzle)
  puzzle.each do |line|
    puts line.join(" ")
  end
end

puts "input puzzle name"
puzzle_name = "puzzles/" + gets.chomp
puzzle_arr = []

File.open(puzzle_name, "r") do |file|
  while(line = file.gets)
    puzzle_arr.push line.scan(/\d/)
  end
end

solve(puzzle_arr)