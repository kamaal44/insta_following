require 'instagram_scrap'

namespace :auto_following do
  
  desc "Follow on instagram"
  task follow: :environment do
    
    insta = InstagramScrap.new("insta_scrape", "instascrape")
    insta.login

    users = ["josephineskriver", "theweeknd", "kendalljenner", "karliekloss"]
    insta.follow(insta.get_browser_object, users[0])
    binding.pry
    # insta.follow
  end

  desc "UnFollow on instagram"
  task unfollow: :environment do
    # insta = InstagramScrap.new("insta_scrape", "instascrape")
    # insta.login
    # binding.pry
  end

end
