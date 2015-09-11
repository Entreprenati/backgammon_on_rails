class RankingsController < ApplicationController

  def rankings_request

    records = User.all
    puts "Current username games won: #{records.find_by(id: session[:current_user_id]).num_wins}"

    User.update(session[:current_user_id], last_activity: Time.now)

    @rankings_hash = {}
    records.each do |x|
      if ( (x.num_games == 0) || (x.num_wins == 0) )
        percentage = 0
      else
        percentage = ( (x.num_wins.to_f / x.num_games) * 100 ).round(2)
      end
      puts "Percentage is: #{percentage}" 
      @rankings_hash[x.username] = [x.num_games, x.num_wins, percentage]
    end 

    @rankings_hash = @rankings_hash.sort_by{|k,v| v[2]}.reverse
      
    return render "rankings"

  end

end
