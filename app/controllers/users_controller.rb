class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy ]
	before_action :require_admin, only: [:destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 3)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "Your details have been saved. Welcome to the community! Please login..."
			redirect_to login_path
		else
			render 'new'
		end
	end

	def edit
		
		
	end

	def update
		if @user.update(user_params)
			flash[:success] = "Your account was updated"
			redirect_to articles_path
		end

	end

	def show
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 3)
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		flash[:danger] = "User and all articles by user have been deleted"
		redirect_to users_path
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end
		
	def require_same_user
		if  current_user != @user and !current_user.admin?
			flash[:danger] = "You can only enter your own account"
			redirect_to root_path
		end
	end

	def require_admin
		if logged_in? and !current_user.admin? 
			flash[:danger] = "Only admin's can perform that action"
			redirect_to root_path
		end
	end
		
	

end
