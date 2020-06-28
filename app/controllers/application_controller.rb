
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do			
    @article = Article.create(params)
    @article_id = Article.last.id
    redirect to "/articles/#{Article.last.id}"
  end 			
  
  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end
  
  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.title = params[:title]
    @article.content = params[:content]
    @article.save
    erb :show	
  end

  delete '/articles/:id' do					
    @article = Article.find_by_id(params[:id])
    @article.delete
    redirect '/articles'
  end

end
