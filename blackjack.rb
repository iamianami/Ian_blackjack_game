
#set dealer's name.
name = File.open("name_list.txt","r") do |name|
  name.read
end.split

dealer_name = name.sample

#calcualte the value of the cards
def calculate_total(cards)
  card_number = cards.map{|card| card[1] } 

  total = 0
  card_number.each do |number|
    if number == "A"
      total += 11
    elsif number.to_i == 0 #means J,Q,K. "string.to_i => 0"
      total += 10
    else 
      total += number.to_i
    end
  end

#If the cards set have "A" and total is > 21,"A" = 1
  card_number.select{|number| number == "A" }.count.times do
    total -= 10 if total > 21
  end

  total
end 

#Greeting

puts ""
puts "=================== BlackJack ===================="
puts ""
puts "          -----Please enter your name-----         "
player_name = gets.chomp.capitalize
puts ""
puts "-------------------------------------------------------"
puts " Hello #{player_name}!Welcome to BlackJack game!"
puts " My name is #{dealer_name}.I'm the dealer of this table."
puts " Hope you enjoy the game. "
puts "-------------------------------------------------------"

#define cards

suits = ["H","D","S","C"]
cards = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]

deck = suits.product(cards)

#Examine the cards

loop do
  puts ""
  puts "=====Do you want to examine the cards? (y/n)====="
  Check_the_card = gets.chomp.downcase
  if !["y","n"].include?(Check_the_card)
    puts "Error Type!plese type 'y' or 'n' "
    next
  end

  if Check_the_card == "y"
    puts ""
    p deck
    break
  else
    puts "Ok,you don't want to check the card."
    puts "Lets start the game."
    break
  end
end

#shuffle the card
puts ""
puts ""
puts "     -----------------------------------------------------"
puts "    |If you're ready,type 'Y' and cards will be shuffled. |"
puts "     -----------------------------------------------------"
puts ""
puts " ------------------------------------------------------------------"
puts "|If you scare to gamble with the dealer,please type 'EXIT' to out. |"
puts " ------------------------------------------------------------------"
shuffle_or_exit = gets.chomp.downcase
if shuffle_or_exit == "y"
  puts ".....Cards shuffling......"
  sleep 0.5
  puts "......"
  sleep 0.5
  puts ".........."
  sleep 0.5
  puts "..............."
  sleep 0.5
  puts "....................DONE"
  deck.shuffle!
else
  exit
end

#dealing cards:dealer and player will have two cards for each at first

#loop do  
  puts ""
  puts "++++++++++++++++"
  puts "Let's get start "
  puts "++++++++++++++++"
  puts ""
  sleep 1
  player_cards = []
  dealer_cards = []
  player_cards << deck.pop
  player_cards << deck.pop
  dealer_cards << deck.pop
  dealer_cards << deck.pop

  player_cards_total = calculate_total(player_cards)
  dealer_cards_total = calculate_total(dealer_cards)

  #show the cards

  puts "Dealer #{dealer_name} has cards : #{dealer_cards[0]} and #{dealer_cards[1]}"
  puts "Total is : #{dealer_cards_total}" 
  puts ""
  puts "#{player_name} has cards  : #{player_cards[0]} and #{player_cards[1]}"
  puts "Total is : #{player_cards_total}" 
  
  #player turn.Make a choice

  if player_cards_total == 21
    puts "--------------------win-----------------------------"
    puts ""
    puts "You're so lucky,#{player_name},you hit BlackJack."
    puts "You won!"
    puts ""
    puts "--------------------win-----------------------------"
  end

  if dealer_cards_total == 21
    puts "Sorry,#{dealer_name} hit BlackJack,You lose"
  end

  while player_cards_total < 21
    puts ""
    puts "What would you like to do? #{player_name},do you want hit or stay?"
    puts "Hint:Enter 'h' for hit,'s' for stay."
    player_choice = gets.chomp.downcase

    if !["h","s"].include?(player_choice)
      puts "Warning:  Wrong typing"
      puts "Please type 'h' or 's'."
    end

    if player_choice == "s"
      puts ""
      puts ""
      puts "--------------------------------------------"
      puts "You choose stay,now is #{dealer_name}'s turn"
      puts "--------------------------------------------"
      puts ""
      puts ""
      sleep 2
      break
    end
   
    player_new_card = deck.pop
    puts "Dealing new card #{player_new_card} to #{player_name}"
    puts ""
    player_cards << player_new_card
    player_cards_total = calculate_total(player_cards)
    puts "Total value of #{player_name}'s cards is #{player_cards_total}" 
    puts ""
    
    if player_cards_total == 21
      puts "Congratulations ,you hit BlackJack"
      puts ""
      break
    elsif player_cards_total > 21
      puts ""
      puts "--------HaHaHaHa---------"
      puts "|                       |"
      puts "|      YOU BUSTED!!     |"
      puts "|                       |"
      puts "|      DEALER WINS!     |"
      puts "|                       |"
      puts "--------HaHaHaHa---------"
      puts ""
      exit
    end
  end
  # puts "Hey,#{player_name},do you want to try again? (Y/N)"
  # try_again_answer = gets.chomp.downcase 
  #   if try_again_answer == "y"
  #     next
  #   else
  #     exit
  #   end
#end

  #Dealer turn

  while dealer_cards_total < 17
    dealer_new_card = deck.pop
    puts "Dealing new card #{dealer_new_card} to dealer #{dealer_name}"
    puts ""
    dealer_cards << dealer_new_card
    dealer_cards_total = calculate_total(dealer_cards)
    puts ""
    puts "Total value of #{dealer_name}'s cards is #{dealer_cards_total}"

    if dealer_cards_total == 21
      puts "Sorry,#{dealer_name} hit BlackJack,You lose"
      puts ""
    elsif dealer_cards_total > 21
      puts "Dealer busted,#{player_name} win!"
      puts ""
      exit
    end
  end

  #compare dealer's card and player's card

  puts "#{dealer_name}'s cards:"
  puts "#{dealer_cards}"
  puts "Total:#{dealer_cards_total}"
  puts ""

  puts "#{player_name}'s cards:"
  puts "#{player_cards}"
  puts "Total:#{player_cards_total}"
  puts ""

  if dealer_cards_total > player_cards_total
    puts "Sorry,dealer #{dealer_name} wins"
  elsif dealer_cards_total < player_cards_total
    puts "Congratulations #{player_name} wins!"
  else
    puts "It's a tie!"
  end

  exit


        
  