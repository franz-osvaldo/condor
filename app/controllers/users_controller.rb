class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.new
    flash.now[:users] = 'in'
  end
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html{}
      format.js{}
    end
  end

  def create
    # render :text => params.inspect
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.js{}
      else
        format.js{ render 'errors_messages' }
      end
    end
  end

  def update
    # render :text => params.inspect
    @user = User.find(params[:id])
    if !params.has_key?(:avatar) && params[:eliminado] == 'si'
      @user.avatar = nil
    end
    respond_to do | format|
      if @user.update(user_params)
        format.html { redirect_to @user}
        format.js{}
      else
        # format.html { redirect_to edit_user_path(@user)}
        format.html{ render :edit}
        format.js{ render 'errors_messages' }
      end
    end
  end

  def update_role
    # render :text => params.inspect
    @user = User.find(params[:id])
    @user.update_attribute(:occupation_id, params[:user][:occupation_id])
    @user.update_attribute(:receiver, params[:user][:receiver])
    respond_to do |format|
      format.js{}
    end
  end

  def destroy
    @user = User.find(params[:id])
    @destroyed = @user.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :occupation_id, :password, :password_confirmation, :avatar, :receiver)
  end

end
