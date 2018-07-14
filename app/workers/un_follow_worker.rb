require 'instagram_scrap'
class UnFollowWorker
  include Sidekiq::Worker

  def perform
    # browser = InstagramScrap.set_browser_object()
    # loop do
      Partner.all.each do |partner|
        insta = InstagramScrap.new(partner.name, partner.password)
        insta.login
        partner.insta_accounts.each do |insta_account|
          insta.unfollow(insta.browser, insta_account, partner)
          sleep(10)
        end
        insta.logout(insta.browser, partner)
      end
    # end
  end
end
