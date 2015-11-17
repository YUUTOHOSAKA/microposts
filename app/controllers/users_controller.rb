class UsersController < ApplicationController
  
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"#Railsで一時的なメッセージ（フラッシュメッセージ）を表示するためにはredirect_toやrenderの前に、flashというハッシュに:success、:alertなどのキーを指定してメッセージを代入します。
      redirect_to @user #今回←はredirect_to user_path(@user)と同じように動作する
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end