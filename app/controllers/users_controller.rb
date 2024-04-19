class UsersController < ApplicationController
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: "Address updated successfully."
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:address)
  end
end
