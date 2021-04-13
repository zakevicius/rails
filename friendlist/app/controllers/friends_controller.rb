class FriendsController < ApplicationController
  before_action :set_friend, only: [:show, :edit, :update, :destroy]

  # GET /friends
  # GET /friends.json
  def index
    @friends = Friend.all
  end

  # GET /friends/1
  # GET /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new
  end

  # GET /friends/1/edit
  def edit
  end

  # POST /friends
  # POST /friends.json
  def create
    @friend = Friend.new(friend_params)
    
    respond_to do |format|
      if @friend.save
        upload_to_s3
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
    move_to_other_bucket
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

  def upload_to_s3
    data = {
      first_name: @friend.first_name,
      last_name: @friend.last_name
    }

    filename = "#{@friend.first_name}.json"

    AwsS3Service.new(region: 'eu-north-1').upload_file(data, filename, key)
  end

  def move_to_other_bucket
    client = Aws::S3::Client.new(
      region: 'eu-north-1',
      credentials: Aws::Credentials.new(Rails.application.secrets.aws_access_key, Rails.application.secrets.aws_secret_key)
    )
    s3 = Aws::S3::Resource.new(client: client)
    object = s3.bucket('test-m-photo').object(key)

    object.move_to(bucket: 'kms-test-m', key: key)
  end

  def key
    @key ||= "friends/#{@friend.id}/#{filename}"
  end
  
  def filename
    @filename ||= "#{@friend.first_name}.json"
  end
end
