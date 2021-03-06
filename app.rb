require "sinatra/base"
require "./lib/player.rb"
require "./lib/game.rb"
require "./lib/computer.rb"

class RPS < Sinatra::Base
  enable :sessions

  get "/" do
    erb(:index)
  end

  post "/name" do
    player = Player.new(params[:player_name])
    computer = Computer.new
    $game = Game.new(player, computer)
    redirect "/play"
  end

  get "/play" do
    @game = $game
    erb(:play)
  end

  post "/choice" do
    $game.player.choice = params[:choice]
    $game.computer.choose_weapon
    redirect "/result"
  end

  get "/result" do
    erb(:result)
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
