require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'headless'

class InstagramScrap
  
  def initialize(username, password)
    @username, @password = username, password
  end

  def self.set_browser_object
    headless = Headless.new
    headless.start
    @@browser = Watir::Browser.new :chrome
  end

  def self.get_browser_object
    @@browser
  end

  def login
    @@browser.goto "instagram.com/accounts/login/"
    @@browser.text_field(:name => "username").set "#{@username}"
    @@browser.text_field(:name => "password").set "#{@password}"
    @@browser.button(:text => 'Log in').click
    sleep(2)
  end

  def follow(browser, insta_account, partner)
    user = insta_account.name
    # Navigate to user's page
    browser.goto "instagram.com/#{user}/"    
    if browser.link(:text => /followers/).present?
      browser.link(:text => /followers/).click
      sleep(2)
      puts "======================== Started Following For #{user}=================="
      # Follow 10 users
      count = 0
      5.times do
        following_user_element = browser.div(:text => "Followers").next_sibling.buttons(:text => "Follow")[count]
        if following_user_element.exist?
          followed_user_username = following_user_element.parent.parent.parent.text.split("\n").first
          
          following = Following.find_or_create_by(name: followed_user_username)
          partner_insta_account = insta_account.partner_insta_accounts.where("insta_account_id = ? AND partner_id = ?", insta_account.id, partner.id).first
          unless following.partner_insta_account_followings.find_by(partner_insta_account_id: partner_insta_account.id).present?
            following_user_element.click
            sleep(2)
            puts "#{followed_user_username} instagram user followed by #{partner.name}."
            following.partner_insta_account_followings.create(partner_insta_account_id: partner_insta_account.id, followed_at: Time.now)
          else
            count = count + 1
          end
        else
          break
        end
      end
    end
    puts "======================== Finished Following for #{user}=================="
  end

  def logout(browser, partner)
    browser.goto("https://www.instagram.com/#{partner.name}")
    sleep(2)
    browser.button(:text => "Options").click
    browser.button(:text => "Log Out").click
    puts "Voila Logout successful!!"
  end

  def unfollow(browser, insta_account, partner)
    user = insta_account.name
    partner_insta_account = insta_account.partner_insta_accounts.where("insta_account_id = ? AND partner_id = ?", insta_account.id, partner.id).first
    partner_insta_account.followings.each do |following|
      partner_insta_account_following = partner_insta_account.partner_insta_account_followings.where("following_id=? AND partner_insta_account_id=?", following.id, partner_insta_account.id).first
      if partner_insta_account_following.created_at < (DateTime.now)
        browser.goto "https://www.instagram.com/#{following.name}/"
        if browser.button(:text => "Following").exist?
          browser.button(:text => "Following").click
          sleep(2)
          if browser.button(:text => "Follow").exist?
            puts "#{following.name} instagram user Un-followed by #{partner.name}."
            partner_insta_account_following.unfollow = true
            partner_insta_account_following.save
          end
        end
      end
    end
    puts "======================== Finished Un-following for #{user} =================="
  end
end
