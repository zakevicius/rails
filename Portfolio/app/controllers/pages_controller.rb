# frozen_string_literal: true

class PagesController < ApplicationController
  def home
    ap Blog.all
  end

  def about; end

  def contact; end
end
