class HomesController < ApplicationController
  def top
  end

  def about
  end

  def book_search
    @book = Book.new
    @books = Book.where("category LIKE?", "#{params[:keyword]}")
  end
end
