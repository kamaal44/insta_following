require 'watir' # Crawler
require 'pry' # Ruby REPL

class InstagramScrap
  # username = "insta_scrape"
  # password = "instascrape"
  
  def initialize(username, password)
    @username, @password = username, password
    @browser = Watir::Browser.new :chrome
  end

  def get_username
    @username
  end

  def get_password
    @password
  end

  def get_browser_object
    @browser
  end

  def login
    @browser.goto "instagram.com/accounts/login/"
    @browser.text_field(:name => "username").set "#{@username}"
    @browser.text_field(:name => "password").set "#{@password}"
    @browser.button(:text => 'Log in').click
    sleep(2)
  end

  # users = ["josephineskriver", "theweeknd", "kendalljenner", "karliekloss"]
  
  
  # Open Browser, Navigate to Login page
  # browser = Watir::Browser.new :chrome
  # browser.goto "instagram.com/accounts/login/"

  # Navigate to Username and Password fields, inject info
  # puts "Logging in..."
  # browser.text_field(:name => "username").set "#{username}"
  # browser.text_field(:name => "password").set "#{password}"

  # Login
  # browser.button(:text => 'Log in').click
  # sleep(2)
  # puts "We're in #hackerman"

  def follow(browser, insta_account, partner)
    user = insta_account.name
    # Navigate to user's page
    browser.goto "instagram.com/#{user}/"
    
    # Click Followers Button

    if browser.link(:text => /followers/).present?
      browser.link(:text => /followers/).click
      sleep(2)
      # Follow 10 users
      puts "======================== Started Following =================="
      # partner = Partner.first
      # insta_account = InstaAccount.find_or_create_by(name: user)
      # partner_insta_account = partner.partner_insta_accounts.create(insta_account_id: insta_account.id)

      10.times do
        following_user_element = browser.div(:text => "Followers").next_sibling.buttons(:text => "Follow")[0]
        if following_user_element.exist?
          following_user_element.click
          sleep(2)
          followed_user_username = following_user_element.parent.parent.parent.text.split("\n").first
          # puts "Followed user #{followed_user_username}"
          following = Following.find_or_create_by(name: followed_user_username)
          partner_insta_account = insta_account.partner_insta_accounts.where("insta_account_id = ? AND partner_id = ?", insta_account.id, partner.id).first
          following.partner_insta_account_followings.create(partner_insta_account_id: partner_insta_account.id, followed_at: Time.now)
        else
          break
        end
      end
    end
    puts "======================== Finished Following =================="
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
            partner_insta_account_following.unfollow = true #condition needed when unfollow
            partner_insta_account_following.save
          end
        end
      end
    end

    # unfollow = []
    # @@database[user].select{ |value_hash| unfollow << value_hash["followed_user"] if value_hash["followed_at"] < (Time.now - (2)) }
    #   puts "======================== Un-following =================="
    # #Unfollow person who has been followed one day ago.
    # unfollow.each_with_index do |follower, index|
    #   sleep(2)
    #   browser.goto "https://www.instagram.com/#{follower}/"
      # if browser.button(:text => "Following").exist?
      #   browser.button(:text => "Following").click
      #   if browser.button(:text => "Follow").exist?
      #     puts "Un-followed user #{follower}"
      #     @@database[user].delete_if{ |value| value["followed_user"] == follower }
      #   end
      # end
    #   break if (index >= 9)
    # end
    puts "======================== Finished Un-following =================="
    # sleep(10) # Sleep 15 minutes (900 seconds)
  end

  # Continuous loop to run until you've unfollowed the max people for the day
  # loop do
  #   users.each do |user|
  #     InstagramScrap.new("insta_scrape", "").follow(@browser, user)
  #     unfollow(@browser, user)
  #   end
  #   sleep(5) # Sleep 1 hour (3600 seconds)
  # end
end
