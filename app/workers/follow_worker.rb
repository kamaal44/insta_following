require 'instagram_scrap'
class FollowWorker
  include Sidekiq::Worker

  def perform
    # browser = InstagramScrap.set_browser_object()
    100.times do 
      Partner.all.each do |partner|
        
        insta = InstagramScrap.new(partner.name, partner.password)
        insta.login
        partner.insta_accounts.each do |insta_account|
          insta.follow(insta.browser, insta_account, partner)
        end
        insta.logout(insta.browser, partner)
        sleep(3)
        insta.browser.close
      end
    end
  end
end
