

namespace :auto_following do
  
  desc "Follow on instagram"
  task follow: :environment do
    FollowWorker.perform_async
  end

  desc "UnFollow on instagram"
  task unfollow: :environment do
    UnFollowWorker.perform_async
  end
end
