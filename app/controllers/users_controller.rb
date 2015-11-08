class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:UserName, :EMail, :TelPhoneNo)
    end

    def sendCode
      remote_url = "http://n4ke-kne.mp4"
      enc_dl_url = Qiniu::Utils.urlsafe_base64_encode(remote_url)
      encode_entry_uri = Qiniu::Utils.encode_entry_uri('thebeast',"#{Time.now}.mp4")
      path = "/fetch/#{enc_dl_url}/to/#{encode_entry_uri}"
      host = "http://iovip.qbox.me"
      uri = URI.parse "#{host}#{path}"
      http = Net::HTTP.new(uri.host, uri.port)
      signing_str = path+"\n"
      encoded_sign = HMAC::SHA1.digest(signing_str,Qiniu::Config.settings[:secret_key])
      request = Net::HTTP::Post.new(uri.path)
      request.add_field('Content-Type', 'application/x-www-form-urlencoded')
      request.add_field('Host','iovip.qbox.me')
      request.add_field("Athorization","QBox #{Qiniu::Config.settings[:access_key]}:#{encoded_sign}")
      response = http.request(request)
    end
end
