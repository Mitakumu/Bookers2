class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = User.new
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      @books = Book.page(params[:page]).reverse_order
      @user = current_user
      render :index
    end

  end

  def index
    @book = Book.new
    @books = Book.page(params[:page]).reverse_order
    @user = current_user
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.page(params[:page]).reverse_order
    @newbook = Book.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "successfully"
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


end
