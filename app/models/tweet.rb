class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user



  def self.tweet_getter(user)
    tweets = Twitter.user_timeline(user.username, count: 10,
                                            include_rts: false)
    tweets_array = []
    
    tweets.each do |tweet|
      tweets_array << Tweet.create(user_id: user.id,
                                      text: tweet.text,
                                created_at: Time.now)
    end
    tweets_array
  end

end
