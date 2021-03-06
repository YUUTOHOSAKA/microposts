class UsersController < ApplicationController
  before_action :set_message, only: [:edit, :update]
  before_action :logged_in_user, only: [:edit, :update]

  
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
  
  def edit
    if current_user != @user
      redirect_to root_url
    end
  end
  
  def update
    if current_user != @user
      redirect_to root_url
    else
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
    end
  end
  
  # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,:profile,:from,
                                 :password_confirmation)
                                 
  
  end
  def set_message
    @user = User.find(params[:id])
  end
end