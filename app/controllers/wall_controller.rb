class WallController < ApplicationController

  def send_wall

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)

    current_user_id = session[:current_user_id].to_i
    @record = User.find_by( id: current_user_id )
    @username = @record.username
    @user = @record

    # Create list of pending foe requests to user 

    foe_requests_to_user_records = Foe.where( "foe_responder_id = ? AND status = ?", current_user_id, 0 ).to_a

    @foe_requests_to_user = []

    if foe_requests_to_user_records.present?

      foe_requests_to_user_records.each do |record|
        @foe_requests_to_user.push( User.find_by( id: record['foe_requester_id'] ).username ) 
      end

    end

    # Create list of pending foe requests from user 

    foe_requests_from_user_records = Foe.where( "foe_requester_id = ? AND status = ?", current_user_id, 0 ).to_a

    @foe_requests_from_user = []

    if foe_requests_from_user_records.present?

      foe_requests_from_user_records.each do |record|
        @foe_requests_from_user.push( User.find_by( id: record['foe_responder_id'] ).username ) 
      end

    end


    # Create list of user's foes & status of games with each (no game, your move, or waiting)

    foe_records = Foe.where( "(foe_requester_id = ? OR foe_responder_id = ?) AND status = ?", current_user_id, current_user_id, 1 ).to_a

    foes = []
    
    if foe_records.present?

      foe_records.each do |record|

        foes.push( User.find_by( id: record['foe_requester_id'] ).username ) if record['foe_requester_id'] != current_user_id

        foes.push( User.find_by( id: record['foe_responder_id'] ).username ) if record['foe_responder_id'] != current_user_id

      end

      game_records = Game.where( "white_player_id = ? OR black_player_id = ?", current_user_id, current_user_id ).to_a
      puts "Games are  + #{game_records}"

      games = []
      game_records.each do |record|

        # if Game.where( "id =?", record['white_player_id'] ).to_a.length != 0
        #   games.push( Game.find_by( id: record['white_player_id'] ).id ) if record['white_player_id'] != current_user_id
        # end

        # if Game.where( "id =?", record['black_player_id'] ).to_a.length != 0
        #   games.push( Game.find_by( id: record['black_player_id'] ).id ) if record['black_player_id'] != current_user_id
        # end

        games.push(record['id']) 
        puts "Games are: #{games}"

      end

      @foe_games = []
      foes.each do |f|
        status = 0
        games.each do |g|

          status = 1 if Game.find_by( id: g ).white_player_id == User.find_by( username: f ).id  && Game.find_by( id: g ).turn  == 1 

          status = 1 if Game.find_by( id: g ).black_player_id == User.find_by( username: f ).id  && Game.find_by( id: g ).turn  == 0

          status = 2 if Game.find_by( id: g ).white_player_id == User.find_by( username: f ).id  && Game.find_by( id: g ).turn  == 0 

          status = 2 if Game.find_by( id: g ).black_player_id == User.find_by( username: f ).id  && Game.find_by( id: g ).turn  == 1

          status = 1 if Game.find_by( id: g ).white_player_id == User.find_by( username: f ).id && f === 'Computer'

        end
        @foe_games.push([f,status])

      end
      puts "foe_games are: #{@foe_games}"

    end

    return render "wall"

  end

  def foe_request

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)

    foe_requester_id = session[:current_user_id].to_i
    foe_responder_username = params[:foe_responder_username]

    return render :text => "No member has that username - try again." if !User.exists?( username: foe_responder_username )

    foe_responder_id = User.find_by( username: foe_responder_username ).id

    check = Foe.where( "(foe_requester_id = ? AND foe_responder_id = ?) OR (foe_requester_id = ? AND foe_responder_id = ?)", foe_requester_id, foe_responder_id, foe_responder_id, foe_requester_id ).to_a

    puts "Check is: #{check}"

    return render :text => "Requested Foe Already Your Foe Or A Related Foe Request Is Pending!" if check.length != 0 

    Foe.create( foe_requester_id: foe_requester_id, foe_responder_id: foe_responder_id, status: 0 )
    return render :text => "Foe Request Sent!"

  end

  def foe_response

    if !session.exists?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    if session[:current_user_id].blank?
      flash.alert = "Ooops . . . you must be logged in."
      return redirect_to '/'
    end

    User.update(session[:current_user_id], last_activity: Time.now)

    foe_responder_id = session[:current_user_id].to_i
    foe_requester_username = params[:foe_requester_username]
    foe_requester_id = User.find_by( username: foe_requester_username ).id
    response = params[:response].to_i

    record_id = Foe.find_by( "foe_requester_id = ? AND foe_responder_id = ?", foe_requester_id, foe_responder_id ).id
    
    Foe.update( record_id, :status => response )
    # flash.notice = "Foe accepted." if response == 1
    # flash.notice = "Foe rejected." if response == 2
    return render :text => "Foe Accepted!" if response == 1
    return render :text => "Foe Rejected!" if response == 2
  end

  def logout
    User.update(session[:current_user_id], logged_in: 0)
    session.clear
    return redirect_to '/'
  end

end