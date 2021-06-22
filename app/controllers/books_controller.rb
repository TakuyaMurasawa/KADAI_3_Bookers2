class BooksController < ApplicationController

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    
    redirect_to book_path(@book.id)
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    # Nに値するbookのuser_idカラムをもとにUserからuse.idを探す
    # @user = User.find(params[:user_id])
    # @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
