# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    @first = params[:first]
    @second = params[:second]
  end

  def about; end

  def contact; end

  ### Testing custom routing
  # def something
  #   redirect_to root_path(first: params[:anything], second: params[:additional])
  # end
end
