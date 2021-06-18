# frozen_string_literal: true

class FriendsController < ApplicationController
  before_action :set_friend, only: %i[show edit update destroy encrypt decrypt]
  # GET /friends
  # GET /friends.json
  def index
    @friends = Friend.all
  end

  def encrypt
    @encrypted = @friend.encrypt_data
    @friend.update(encrypted: true) if @encrypted["statusCode"] == 200
    render 'show'
  end

  def decrypt
    @decrypted = @friend.decrypt_data
    @friend.update(encrypted: false) if @decrypted["statusCode"] == 200
    render 'show'
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)

    respond_to do |format|
      if @friend.save
        format.html { redirect_to @friend, notice: 'Friend was successfully created.' }
        format.json { render :show, status: :created, location: @friend }
      else
        format.html { render :new }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friends/1
  # PATCH/PUT /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to @friend, notice: 'Friend was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1
  # DELETE /friends/1.json
  def destroy
    @friend.destroy
    respond_to do |format|
      format.html { redirect_to friends_url, notice: 'Friend was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friend
    @friend = Friend.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friend_params
    params.require(:friend).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
  end
end
