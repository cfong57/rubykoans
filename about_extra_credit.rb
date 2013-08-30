# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.

require File.expand_path(File.dirname(__FILE__) + '/neo')

class DiceSet
  attr_accessor :dice
  attr_accessor :values

  def initialize
    @dice = [1, 2, 3, 4, 5, 6]
    @values = []
  end

  def values
    @values
  end

  def roll(howmany = 1)
    results = []
    howmany.abs.times{ results << @dice.sample }
    @values = results
  end
end

class Player
  attr_accessor :name
  attr_accessor :points

  def initialize(name)
    @name = name
    @points = 0
  end
end

class Game
  @players
  attr_accessor :turn

  def initialize
    @players = []
    @turn = 0
  end  

  def players
    @players
  end

  def add_players(*who)
    who.each{|p| @players[p] = Player.new(p)}
  end

  def adjust_score(who, points)
    @players[who].points = points
  end

  def points(who)
    @players[who].points
  end

  def max_player
    max = @players.first
    @players.each do |who|
      max = who if(points(who) > points(max))
    end
    return max
  end

  def max_points
    @players[max_player]
  end

  def score(dice)
    points = 0
    nonscoring = 0
    (1..6).each do |num|
      howmany = dice.count{|x| x == num }
      if(num == 1)
        howmany >= 3 ? points += (1000 + ((howmany - 3) * 100)) : points += howmany * 100
      elsif(num == 5)
        howmany >= 3 ? points += (500 + ((howmany - 3) * 50)) : points += howmany * 50
      else
        if(howmany >= 3)
          points += 100 * num
          nonscoring += (howmany - 3) #since we never roll more than 5, only one possible triplet
        else
          nonscoring += howmany
        end
      end
    end
    return [points, nonscoring]
  end

  def start_game
    dice = DiceSet.new
    puts "GREED starting with #{players.size} players.\n"
    while(max_points < 3000)
      @turn += 1
      players.each do |p|
        puts "#{p.name}'s turn (round #{@turn.to_s}). Score: #{points(p)}"
        dice.roll(5)
        temp = score(dice.values)
        roundscore = temp[0]
        nonscoring = temp[1]
        if(roundscore == 0)
          puts "#{p.name} scores 0. Points and turn lost."
          next
        else
          puts adjust_score(p, roundscore)
          puts "Roll again with #{nonscoring} dice? [y/n], default y"
          choice = gets.chomp.split.downcase
          if(choice == "n")
            puts "#{p.name} declined to roll again. Moving on."
          else
            dice.roll(nonscoring)
            ...
          end
        end
        #end player turns
      end
      #end round
    end
    #final round starts here
  end
  
end

greed = Game.new
greed.add_players("Fred", "Bob")
greed.start_game