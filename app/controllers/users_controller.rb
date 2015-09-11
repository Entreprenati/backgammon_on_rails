class UsersController < ApplicationController

  def create
    
    email_input = params[:email].downcase
    password_input = params[:password]
    username_input  = params[:username]
    email_taken = false
    username_taken = false
    password_match = false
    username_match = false

    email_taken = true if User.exists?( email: email_input )
    username_taken = true if User.exists?( username: username_input )

    if email_taken && username_taken
      record = User.find_by( email: email_input )
      password_match = true if password_input == record.password
      username_match = true if username_input == record.username
      if password_match && username_match
        session[:current_user_id] = record.id
        return render text: record.id.to_s
      end
      return render :text => "Invalid sign up (email & username already taken). Try again:"
    end

    return render :text => "Invalid sign up (email already taken). Try again:" if email_taken

    return render :text => "Invalid sign up (username already taken). Try again:" if username_taken

    User.create( email: email_input, password: password_input, username: username_input, logged_in: 1, last_activity: Time.now, num_games: 0, num_wins: 0 )

    session[:current_user_id] = User.find_by( email: email_input ).id

    Foe.create(foe_requester_id: session[:current_user_id], foe_responder_id: 1, status: 1 )

    return render text: session[:current_user_id].to_s   

  end

  def avatar_update

    puts ""
    puts "params[:user] is: #{params[:user]}"
    puts ""
    puts "params[:user] is: #{user_params}"

    @user = User.find(session[:current_user_id])
    @user.update_attributes(user_params)

    User.update(session[:current_user_id], last_activity: Time.now)

    return redirect_to '/wall_request'

  end

  def user_params
    params.require(:user).permit(:avatar)
  end

end



