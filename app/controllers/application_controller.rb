
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    "Hello"
  end
  
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @articles = Article.new
    erb :new
  end

  post '/articles' do
    @article = Article.create({title:params["title"], content:params["content"]})
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
     erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.update(params[:article]) #whenever i pull from the hash, it becomes a symbol
    redirect "/articles/#{@article.id}" #whenever I have a PATCH< i want to redirect it
  end

  delete '/articles/:id' do
    @article = Article.find(params[:id])
    @article.delete
    redirect "/articles/#{@article.id}"
  end
end
