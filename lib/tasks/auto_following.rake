require 'instagram_scrap'

namespace :auto_following do
  
  desc "Follow on instagram"
  task follow: :environment do
    Partner.all.each do |partner|
      insta = InstagramScrap.new(partner.user_name, partner.password)
      insta.login
      partner.insta_accounts.each do |insta_account|
        insta.follow(insta.get_browser_object, insta_account, partner)
      end
    end
  end

  desc "UnFollow on instagram"
  task unfollow: :environment do
    Partner.all.each do |partner|
      insta = InstagramScrap.new(partner.user_name, partner.password)
      insta.login
      partner.insta_accounts.each do |insta_account|
        insta.unfollow(insta.get_browser_object, insta_account, partner)
        sleep(10)
      end
    end
  end
end
