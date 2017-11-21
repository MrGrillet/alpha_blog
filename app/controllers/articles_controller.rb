class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def new 
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:notice] = "Your article has been updated"
			redirect_to article_path(@article)
		else
			rneder 'edit'
		end
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			flash[:notice] = "Your article was saved!"
			redirect_to article_path(@article)
		else
			render 'new'
		end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		flash[:notice] = "Article was successfully deleted"
		redirect_to articles_path
	end

	end

	private
		def article_params
			params.require(:article).permit(:title, :description)
		end
end