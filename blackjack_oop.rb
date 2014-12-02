class Card
  attr_reader :value, :suit

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{value} of #{suit}"
  end
end

class Deck
  attr_reader :cards

  def initialize(number_of_decks)
    @cards = []
    number_of_decks.times do
      ["Clubs", "Diamonds", "Hearts", "Spades"].each do |suit|
        (2..10).each do |value|
          @cards << Card.new(suit, value)
        end
        ["Jack", "Queen", "King", "Ace"].each do |value|
          @cards << Card.new(suit, value)
        end
      end
    end
    @cards.shuffle!
  end

  def deal_card
    cards.pop
  end
end

module Hand
  def add_dealt_card(deck)
    hand << deck.deal_card
  end

  def display_hand
    puts "#{name} has been dealt:" 
    hand.each { |card| puts "#{card}" }
  end

  def display_last_card_dealt
    puts "#{name} has been dealt: #{hand.last}"
  end

  def calculate_total
    total = 0
    hand.each do |card|
      if card.value == "Ace"
        total += 11
      elsif card.value.to_i == 0
        total += 10
      else
        total += card.value
      end
    end

    hand.select { |card| card.value == "Ace"}.count.times do
      total -= 10 if total > 21
    end

    total
  end

  def display_total
    puts "#{name}'s total is #{calculate_total}."
  end
end

class Player
  include Hand
  attr_accessor :name, :hand

  def initialize
    @name = ""
    @hand = []
  end

  def get_name
    puts "What is your name?"
    @name = gets.chomp
    puts "Good luck #{@name}!"
  end
end

class Dealer
  include Hand
  attr_accessor :name, :hand

  def initialize
    @name = "Dealer"
    @hand = []
  end
end

class Blackjack
  attr_accessor :player, :dealer, :deck

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new(1)
  end

  def welcome_message
    puts "Welcome to Blackjack!"
  end

  def deal_initial_hands
    2.times do
      player.add_dealt_card(deck)
      dealer.add_dealt_card(deck)
    end
  end

  def display_hands
    player.display_hand
    dealer.display_hand
  end

  def check_blackjack(player_or_dealer)
    if player_or_dealer.calculate_total == 21
      puts "#{player_or_dealer.name} has blackjack! #{player_or_dealer.name} wins!"
      exit
    end
  end

  def display_totals
    player.display_total
    dealer.display_total
  end

  def hit(player_or_dealer)
    player_or_dealer.add_dealt_card(deck)
    player_or_dealer.display_last_card_dealt
    player_or_dealer.display_total
  end

  def check_if_busted(player_or_dealer)
    if player_or_dealer.calculate_total > 21
      puts "#{player_or_dealer.name} is bust! #{player_or_dealer.name} loses!"
      exit
    end
  end

  def player_turn
    begin
      begin
        puts "#{player.name}, would you like to hit (h) or stay (s)?"
        player_choice = gets.chomp.downcase
      end until ["h", "s"].include?(player_choice)

      case player_choice
      when "s"
        puts "#{player.name} has chosen to stay. Dealer will now play."
      when "h"
        puts "#{player.name} has chosen to hit."
        hit(player)
        check_if_busted(player)
      end
    end until player_choice == "s"
  end

  def dealer_turn
    while dealer.calculate_total < 17
      hit(dealer)
      check_if_busted(dealer)
    end
  end

  def check_winner
    if player.calculate_total > dealer.calculate_total
      puts "#{player.name} wins!"
    elsif player.calculate_total < dealer.calculate_total
      puts "#{dealer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play
    welcome_message
    player.get_name
    deal_initial_hands
    display_hands
    check_blackjack(player)
    check_blackjack(dealer)
    display_totals
    player_turn
    dealer_turn
    check_winner
  end
end

Blackjack.new.play

