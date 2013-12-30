require 'bundler'
Bundler.require
require './lib/rabbit'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/rabbits.db")

get '/rabbits' do
  @rabbits = Rabbit.all
  erb :index  
end

get '/rabbits/new' do
  @rabbit = Rabbit.new
  erb :new
end

post '/rabbits' do
  @rabbit = Rabbit.new(params[:rabbit])
  if @rabbit.save
    status 201
    redirect '/rabbits/' + @rabbit.id.to_s
  else
    status 400
    erb :new
  end
end

get '/rabbits/edit/:id' do
  @rabbit = Rabbit.get(params[:id])
  erb :edit
end

put '/rabbits/:id' do
  @rabbit = Rabbit.get(params[:id])
  if @rabbit.update(params[:id])
    status 201
    redirect '/rabbits/' + params[:id]
  else
    status 400
    erb :edit
  end
end

get '/rabbits/delete/:id' do
  @rabbit = Rabbit.get(params[:id])
  erb :delete
end

delete '/rabbits/:id/' do
  Rabbit.get(params[:id]).destroy
  redirect '/rabbits'
end

get '/rabbits/:id' do
  @rabbit = Rabbit.get(params[:id])
  erb :show
end

DataMapper.auto_upgrade!