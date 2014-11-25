class Player
  attr_accessor :name, :choice

  def initialize(name)
    @name = name
    @choice = nil
  end

  def choose
    @choice = gets.chomp.downcase
  end
  
end

class Computer
  attr_accessor :choice

  def initialize
    @choice = nil
  end

  def choose(choices)
    @choice = choices.keys.sample
  end

end

class PaperRockScissors
  attr_accessor :player, :computer, :play_again

  CHOICES = { "p" => "paper", "r" => "rock", "s" => "scissors" }

  def initialize
    @player = Player.new("Bob")
    @computer = Computer.new
    @play_again = "y"
  end

  def display_welcome
    puts "Play Paper Rock Scissors!"
  end

  def ask_for_player_choice
    puts "Choose paper (P), rock (R) or scissors (S):"
  end

  def validate_player_choice
    until CHOICES.keys.include?(player.choice)
      ask_for_player_choice
      player.choose
    end
  end

  def display_choices
    puts "#{player.name} picked #{CHOICES[player.choice]} and computer picked #{CHOICES[computer.choice]}."
  end

  def display_outcome
    case
      when player.choice == computer.choice
        puts "It's a tie."
      when player.choice == "p" && computer.choice == "r"
        puts "Paper wraps rock."
        puts "#{player.name} won!"
      when player.choice == "r" && computer.choice == "p"
        puts "Paper wraps rock."
        puts "Computer won!"
      when player.choice == "p" && computer.choice == "s"
        puts "Scissors cut paper."
        puts "Computer won!"
      when player.choice == "s" && computer.choice == "p"
        puts "Scissors cut paper."
        puts "#{player.name} won!"
      when player.choice == "r" && computer.choice == "s"
        puts "Rock bashes scissors."
        puts "#{player.name} won!"
      when player.choice == "s" && computer.choice == "r"
        puts "Rock bashes scissors."
        puts "Computer won!"
    end
  end

  def play_again?
   begin
      puts "Would you like to play again? (Y/N)"
      @play_again = gets.chomp.downcase
   end until ["y","n"].include?(play_again)
   play_again
  end

  def run
    display_welcome
    while play_again == "y"
      ask_for_player_choice
      player.choose
      validate_player_choice
      computer.choose(CHOICES)
      display_choices
      display_outcome
      play_again?
    end
  end

end

PaperRockScissors.new.run