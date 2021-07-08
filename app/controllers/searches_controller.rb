# class SearchesController < ApplicationController
#   def search
#     @model = params["model"]
#     @content = params["content"]
#     @method = params["method"]
#     @records = search_for(@model, @content, @method)
#   end

#   private
#   def search_for(model, content, method)
#     if model == 'user'
#       if method == 'perfect'
#         User.where(name: content)
#       else
#         User.where('name LIKE ?', '%'+content+'%')
#       end
#     elsif model == 'book'
#       if method == 'perfect'
#         Post.where(title: content)
#       else
#         Post.where('title LIKE ?', '%'+content+'%')
#       end
#     end
#   end
# end

# class SearchesController < ApplicationController
#   before_action :authenticate_user!

#   def search
#     @range = params[:range]
#     @word = params[:word]

#     if @range == "User"
#       @users = User.looks(params[:search], params[:word])
#     else
#       @books = Book.looks(params[:search], params[:word])
#     end
#   end
# end

class SearchesController < ApplicationController
	before_action :authenticate_user!

	def search
	  @books = Book.all
	  @users = User.all
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Book.search_for(@content, @method)
		end
	end
end
