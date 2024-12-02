module SessionsHelper

    # 渡されたユーザーでログインする
    def log_in(user)
        session[:user_id] = user.id
        session[:session_token] = user.session_token      # セッション(一時的な状態管理)固有のトークンを作成　（remember_tokenが盗まれた際のセッションハイジャック対策）　
    end
    
      # 永続的セッションのためにユーザーをデータベースに記憶する
    def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end
    
    # 記憶トークンのcookieに対応するユーザーを返す
    def current_user
        if (user_id = session[:user_id])
          user = User.find_by(id: user_id)
          if user && session[:session_token] == user.session_token      # セッション作成者とログインユーザーが同一かどうか検証
              @current_user = user
          end
        elsif (user_id = cookies.encrypted[:user_id])
          user = User.find_by(id: user_id)
          if user && user.authenticated?(:remember, cookies[:remember_token])
            log_in user
            @current_user = user
          end
        end
    end
    
    # 渡されたユーザーがカレントユーザーであればtrueを返す
    def current_user?(user)
      user && user == current_user
    end
  
    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
      !current_user.nil?
    end
  

    # 永続的セッションを破棄する
    def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
    end
  
    # 現在のユーザーをログアウトする
    def log_out
      forget(current_user)
      reset_session
      @current_user = nil
    end

    # アクセスしようとしたURLを保存する
    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  end
  