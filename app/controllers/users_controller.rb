class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @the_day_before = @today_book.count / @yesterday_book.count.to_f
    @the_week_before = @this_week_book.count / @last_week_book.count.to_f
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def search_book
    @user = User.find(params[:user_id])
    @books = @user.books
    create_at = params[:apple]
    if create_at == ""
      @search_book = "日付を入力してください"
    else
      @search_book = @books.where("created_at LIKE?", "#{create_at}%").count
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def ensure_correct_user
      @user = User.find(params[:id])
      if @user != current_user
        redirect_to user_path(current_user)
      end
    end
end
