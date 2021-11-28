class UsersController < ApplicationController

    def index
        @user = current_user
        @book = Book.new
        @book.user_id = current_user
        @users = User.page(params[:page])
        @books = Book.page(params[:page])
    end

    def show
        @book = Book.new
        @user = current_user
        @user = User.find(params[:id])
        @books = @user.books.page(params[:page]).reverse_order
    end

    def edit
        @user = User.find(params[:id])
        if @user == current_user
            render :edit
        else
            redirect_to user_path(current_user.id)
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          flash[:notice] = "successfully"
          redirect_to user_path(@user.id)
        else
          render :edit
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
