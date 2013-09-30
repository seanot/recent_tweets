get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:handle' do
  # if User.find_by(username: params[:handle])
  if @user = User.find_by_username(params[:handle])
    if Time.now - @user.tweets.first.created_at > 15000
      tweets = Twitter.user_timeline(params[:handle],:count => 10, :include_rts => false)
      @tweets = []
      tweets.each { |tweet| @tweets << Tweet.create(user_id: @user.id, text: tweet.text, created_at: Time.now) }
    else
      @tweets = @user.tweets.limit(10)
    end
  else
    @user = User.create(username: params[:username])
    tweets = Twitter.user_timeline(params[:handle],:count => 10, :include_rts => false)
    @tweets = []
    tweets.each { |tweet| @tweets << Tweet.create(user_id: @user.id, text: tweet.text, created_at: Time.now) }
  end
  erb :tweets
end

post '/tweets' do 
  redirect to("/#{params[:handle]}")
end
