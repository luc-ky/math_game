require './player'

class MathGame
  def initialize
    @player1 = Player.new
    @player2 = Player.new
    @current_player = @player1
  end

  def game_over
    @player1.lives <= 0 || @player2.lives <= 0
  end

  def generate_question
    num1 = rand(1..20)
    num2 = rand(1..20)
    { num1: num1, num2: num2 }
  end

  def check_answer(player, num1, num2, answer)
    correct_answer = num1 + num2
    if answer == correct_answer
      puts "Player #{player == @player1 ? 1 : 2}: YES! You are correct."
      player.increase_score
    else
      puts "Player #{player == @player1 ? 1 : 2}: Seriously? No!"
      player.lose_life
    end
  end

  def display_scores
    score_str = "#{player1.score}/3 vs #{player2.score}/3"
    puts "P1: #{score_str}"
  end

  def player1
    @player1
  end

  def player2
    @player2
  end

  def play
    puts '----- NEW GAME -----'
    until game_over
      question = generate_question
      current_player = @current_player == @player1 ? @player1 : @player2
      puts "Player #{current_player == @player1 ? 1 : 2}: What does #{question[:num1]} plus #{question[:num2]} equal?"
      print '> '
      answer = gets.chomp.to_i
      check_answer(current_player, question[:num1], question[:num2], answer)
      display_scores
      puts '----- NEW TURN -----'
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
    winner = @player1.lives > 0 ? @player1 : @player2
    loser = winner == @player1 ? @player2 : @player1
    winner_index = winner == @player1 ? 1 : 2
    puts "Player #{winner_index} wins with a score of #{winner.score}/3"
    puts '----- GAME OVER -----'
    puts 'Good bye!'
  end
end
