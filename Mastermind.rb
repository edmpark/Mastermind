class Mastermind

  def initialize
    @peg_colors = ["yellow", "orange", "blue", "red", "green", "white"]
    @board = Array.new(12) {Array.new(4)}
    @feedback_board = Array.new(12) {Array.new(4)}
    @code = make_code()  
    p @code
  end

  def win?(guess)
    @code.eql?(guess)
  end

  def play
    puts "Input 1 to be code breaker. Input 2 to be code maker (Computer will be codebreaker)"
    player_type = gets.chomp.to_i
    for i in 0..11 do
      @board[i] = guess(player_type)
      @feedback_board[i] = feedback(@board[i])
      puts @board.map {|x| x.to_s }.join("\n") 
      puts
      puts @feedback_board.map{|x| x.to_s}.join("\n")
      if win?(guess)
        puts "Code Breaker wins"
        return
      end
    end
    puts "Code Maker wins"
  end

  def make_code
    @code = []
    while @code.length() < 4
      color = @peg_colors[rand(0..5)]
      @code << color if !@code.include?(color)
    end
    @code
  end

  def feedback(guess)   #guess is the array of the guessed colors and returns feedback color pegs (white and red in this case)
  	feedback_pegs = []
  	i = 0
    guess.each do |color|
  	  if @code[i] == color      
  	    feedback_pegs << "red"
  	  elsif @code.include?(color)
  	  	feedback_pegs << "white"
      end
      i+=1
    end
    feedback_pegs
  end

  def valid_color? (input)
    @peg_colors.include?(input)
  end

  def guess(type)
    if type == 2
      ai_guess()
    end

    inputs = []
    puts "Input 4 guesses"
    while inputs.length() < 4
      input = gets.chomp
      if !valid_color?(input)
        puts "Invalid input"
      elsif !inputs.include?(input) 
        inputs << input 
      else
        puts "Duplicate input"
      end
    end
    inputs
  end

end


Mastermind.new.play()
