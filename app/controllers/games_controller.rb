class GamesController < ApplicationController

  def challenge

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)

    foe_challenged_username = params[:foe_challenged_username]
    foe_challenged_id = User.find_by(username: foe_challenged_username).id 

    record = Game.find_by( "(white_player_id = ? AND black_player_id = ?) OR (black_player_id = ? AND white_player_id = ?)", foe_challenged_id, session[:current_user_id], foe_challenged_id, session[:current_user_id] )

    if record.present?
      return redirect_to :controller=>'games', :action => 'resume', :foe_to_move_against_username => params[:foe_challenged_username]
    end

    if foe_challenged_username == "Computer"
      white_player_id = 1 
      black_player_id = session["current_user_id"]
      turn = 0
      @turn_status = 0
    else
      black_player_id = session['current_user_id'] 
      white_player_id = User.find_by( username: foe_challenged_username ).id
      turn = 1
      @turn_status = 3
    end 

    record = Game.create(
      white_player_id: white_player_id,
      black_player_id: black_player_id,
      turn: turn,
      turn_status: @turn_status,
      chip0_position: 0,
      chip1_position: 0,
      chip2_position: 11,
      chip3_position: 11,
      chip4_position: 11,
      chip5_position: 11,
      chip6_position: 11,
      chip7_position: 16,
      chip8_position: 16,
      chip9_position: 16,
      chip10_position: 18,
      chip11_position: 18,
      chip12_position: 18,
      chip13_position: 18,
      chip14_position: 18,
      chip15_position: 23,
      chip16_position: 23,
      chip17_position: 12,
      chip18_position: 12,
      chip19_position: 12,
      chip20_position: 12,
      chip21_position: 12,
      chip22_position: 7,
      chip23_position: 7,
      chip24_position: 7,
      chip25_position: 5,
      chip26_position: 5,
      chip27_position: 5,
      chip28_position: 5,
      chip29_position: 5
    )

    @game_id = record.id  
    @current_user_color = "white" if record.white_player_id == session["current_user_id"]
    @current_user_color = "black" if record.black_player_id == session["current_user_id"]
   
    return render "game"

  end

  def resume

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)

    foe_to_move_against_username = params[:foe_to_move_against_username] 

    foe_to_move_against_id = User.find_by(username: foe_to_move_against_username).id
    current_user_id = session["current_user_id"]

    record = Game.find_by( "(white_player_id = ? AND black_player_id = ?) OR (black_player_id = ? AND white_player_id = ?)", foe_to_move_against_id, current_user_id, foe_to_move_against_id, current_user_id )

    return render text: "No such game exists!" if record.blank?
 
    puts "Record is: #{record}"

    @game_id = record.id 
    puts "Game Id is: #{@game_id}"

    @current_user_color = "white" if record.white_player_id == current_user_id
    @current_user_color = "black" if record.black_player_id == current_user_id

    @turn_status = record.turn_status

    puts "Turn status is: #{@turn_status}"

    return render "game"

  end

  def send_situation

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    game_id = params[:game_id].to_i
    situation = Game.find_by( id: game_id ).attributes.to_json
    puts situation
    return render text: situation

  end

  def write_situation

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)

    game_id = params[:game_id].to_i
    puts "Game id is: #{game_id}"
    puts "Turn is: #{params[:turn]}"

    record = Game.find_by( id: game_id)

    if (record.turn == 0 && record.white_player_id == session[:current_user_id]) || (record.turn == 1 && record.black_player_id == session[:current_user_id]) || (record.turn == 0 && record.white_player_id == 1)
    
      Game.update(game_id,
        turn: params[:turn].to_i,
        turn_status: params[:turn_status].to_i,
        chip0_position: params[:chip0_position].to_i,
        chip1_position: params[:chip1_position].to_i,    
        chip2_position: params[:chip2_position].to_i,
        chip3_position: params[:chip3_position].to_i,
        chip4_position: params[:chip4_position].to_i,
        chip5_position: params[:chip5_position].to_i,    
        chip6_position: params[:chip6_position].to_i,
        chip7_position: params[:chip7_position].to_i,
        chip8_position: params[:chip8_position].to_i,
        chip9_position: params[:chip9_position].to_i,    
        chip10_position: params[:chip10_position].to_i,
        chip11_position: params[:chip11_position].to_i,
        chip12_position: params[:chip12_position].to_i,
        chip13_position: params[:chip13_position].to_i,    
        chip14_position: params[:chip14_position].to_i,
        chip15_position: params[:chip15_position].to_i,
        chip16_position: params[:chip16_position].to_i,
        chip17_position: params[:chip17_position].to_i,    
        chip18_position: params[:chip18_position].to_i,
        chip19_position: params[:chip19_position].to_i,
        chip20_position: params[:chip20_position].to_i,
        chip21_position: params[:chip21_position].to_i,    
        chip22_position: params[:chip22_position].to_i,
        chip23_position: params[:chip23_position].to_i,
        chip24_position: params[:chip24_position].to_i,
        chip25_position: params[:chip25_position].to_i,    
        chip26_position: params[:chip26_position].to_i,
        chip27_position: params[:chip27_position].to_i,
        chip28_position: params[:chip28_position].to_i,
        chip29_position: params[:chip29_position].to_i 
      )
      render nothing: true and return

    else

      game_foe_username = User.find_by( id: record.white_player_id ).username if record.white_player_id != session[:current_user_id]

      game_foe_username = User.find_by( id: record.black_player_id ).username if record.black_player_id != session[:current_user_id]

      return redirect_to :controller=>'games', :action => 'resume', :foe_to_move_against_username => game_foe_username

    end

  end

  def check_for_move
    
    game_id = params[:game_id]
    current_user_id = session[:current_user_id]

    record = Game.find_by(id: game_id)

    if (record.turn == 0 && record.white_player_id == current_user_id) || (record.turn == 1 && record.black_player_id == current_user_id)

    game_foe_username = User.find_by(id: record.white_player_id).username if record.white_player_id != current_user_id 

    game_foe_username = User.find_by(id: record.black_player_id).username if record.black_player_id != current_user_id

    return render text: "Yes, it's your move."

    end

    return render text: "Polling for game number: #{game_id}"

  end

  def resume_simultaneous_game

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)    

    game_id = params[:resume_game_id].to_i
    current_user_id = session[:current_user_id].to_i

    puts "game_id is #{game_id}"

    record = Game.find_by(id: game_id)

    (record.turn == 0 && record.white_player_id == current_user_id) || (record.turn == 1 && record.black_player_id == current_user_id)

    game_foe_username = User.find_by(id: record.white_player_id).username if record.white_player_id != current_user_id 

    game_foe_username = User.find_by(id: record.black_player_id).username if record.black_player_id != current_user_id

    return redirect_to :controller=>'games', :action => 'resume', :foe_to_move_against_username => game_foe_username
    
  end

end