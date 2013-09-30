get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:handle' do
  @user = User.find_or_create_by_username(params[:handle])
  tweets = Twitter.user_timeline(params[:handle],:count => 10, :include_rts => false)
  @tweets = []
  tweets.each { |tweet| @tweets << Tweet.create(user_id: @user.id, text: tweet.text, created_at: Time.now) }
  erb :tweets
end

post '/tweets' do   
  redirect to("/#{params[:handle]}")
end
