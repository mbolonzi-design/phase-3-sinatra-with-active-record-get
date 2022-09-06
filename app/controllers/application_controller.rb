class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  get '/games' do
    #get all games fro the database
    games = Game.all.order(:title).limit(7) 
    #return a JSON with an array of games data
    games.to_json
  end
  #dynamic route
  get '/games/:id' do
    game = Game.find(params[:id])
    # include associated reviews in the JSON response
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
