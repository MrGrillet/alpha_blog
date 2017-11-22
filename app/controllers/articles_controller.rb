class ArticlesController < ApplicationController
	before_action :set_article, only: [:destroy, :edit, :update, :show ]

	def index
		@articles = Article.all
	end

	def new 
		@article = Article.new
	end

	def edit
		set_article
	end

	def update
		set_article
		if @article.update(article_params)
			flash[:success] = "Your article has been updated"
			redirect_to article_path(@article)
		else
			rneder 'edit'
		end
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			flash[:success] = "Your article was saved!"
			redirect_to article_path(@article)
		else
			render 'new'
		end

	def show
		set_article
	end

	def destroy
		set_article
		@article.destroy
		flash[:danger] = "Article was successfully deleted"
		redirect_to articles_path
	end

	end

	private
		def set_article
			@article = Article.find(params[:id])
		end

		def article_params
			params.require(:article).permit(:title, :description)
		end
end