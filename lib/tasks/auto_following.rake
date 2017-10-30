require 'instagram_scrap'

namespace :auto_following do
  
  desc "Follow on instagram"
  task follow: :environment do
    browser = InstagramScrap.set_browser_object()
    Partner.all.each do |partner|
      insta = InstagramScrap.new(partner.name, partner.password)
      insta.login
      partner.insta_accounts.each do |insta_account|
        insta.follow(InstagramScrap.get_browser_object, insta_account, partner)
      end
      insta.logout(InstagramScrap.get_browser_object, partner)
    end
  end

  desc "UnFollow on instagram"
  task unfollow: :environment do
    browser = InstagramScrap.set_browser_object()
    Partner.all.each do |partner|
      insta = InstagramScrap.new(partner.name, partner.password)
      insta.login
      partner.insta_accounts.each do |insta_account|
        insta.unfollow(InstagramScrap.get_browser_object, insta_account, partner)
        sleep(10)
      end
      insta.logout(InstagramScrap.get_browser_object, partner)
    end
  end
end
