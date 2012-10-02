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

file = File.new(puzzle_name, "r")
while(line = file.gets)
  puzzle_arr << line.scan(/\d/)
end
file.close

solve(puzzle_arr)