class UsersController < ApplicationController
  def new
  	@user = User.new
  	@all_cities = City.all
  end

  def create
	if params[:password] == '' || params[:email] == ''
	puts "Error : you need to complete this field email/pw"
	flash[:Notice] = "Utilisateur non créé"
	render '/users/new'
	else
 	@user = User.create('last_name': params[:last_name], 'first_name': params[:first_name], 'email': params[:email], 'age': params[:age], 'password': params[:password], 'description': params[:description], 'city_id': params[:city].to_i)	 	
 	puts "The user #{params[:email]} was succesfully saved !"
    flash[:success] = "Utilisateur créé !"
    log_in(@user)
    redirect_to '/'
	end
  end

  def show
    @current_user = User.find(params[:id])
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Utilisateur déconnecté !"
    redirect_to '/login'
  end

end
