# frozen_string_literal: true

# Is the Users controller with methods to sign user up and save their sign-in information.
require 'sinatra/base'
require 'sinatra/flash'

class UsersController < ApplicationController
  # enable :sessions
  register Sinatra::Flash

  get '/teachersapp' do
    erb :homepage
  end

  get '/signup' do
    erb :'users/new'
  end

  # Signs user up and directs them to their homepage
  post '/signup' do
    if params[:name] == '' || params[:email] == '' || params[:password] == ''
      redirect to '/signup'
    else
      @user = User.new(name: params[:name], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/homepage'
    end
  end

  # saves new user's information and directs them to login page
  # if user's info wasn't successfully saved, send them to signup page
  post '/users' do
    @user = User.new
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      session[:successful_signup] = "You have Sucessfully Created an Account"
      redirect '/login'
    else
      erb :'users/new'
    end
  end
end
