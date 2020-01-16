# Helper Methods
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index, current_player)
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  numTurns = 0 
  board.each do |ele|
    if(ele == "X" || ele == "O")
      numTurns += 1 
    end
  end
  return numTurns 
end

def current_player(board)
  if(turn_count(board) % 2 == 0)
    return "X"
  else
    return "O"
  end
end 

def won?(board)
  WIN_COMBINATIONS.each do |combi|
    if(position_taken?(board, combi[0]) && board[combi[0]] == board[combi[1]] && board[combi[1]] == board[combi[2]])
      return combi 
    end
  end
  return nil 
end

def full?(board)
  board.all? { |space| space == "X" || space == "O" }
end 

def draw?(board)
  (full?(board) && !won?(board))
end

def over?(board)
  if(full?(board) || draw?(board) || won?(board))
    return true
  else
    return false
  end
end

def winner(board)
  if(won?(board))
    char = won?(board)
    return board[char[0]] 
   else
     return nil 
   end
end

def play(board)
  while !over?(board)
    turn(board)
  end 
    if(winner(board))
      puts "Congratulations to Player #{winner(board)}! You won!"
    elsif(draw?(board))
      puts "Game ends in a draw."
  end
end 