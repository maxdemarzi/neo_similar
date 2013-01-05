module Job
  class ImportFacebookProfile
    include Sidekiq::Worker
    sidekiq_options :retry => false

    def perform(uid)
      user = User.find_by_uid(uid)
      if user
        # Import Friends
        friends = user.client.get_connections("me", "friends")
        friends.each do |friend|
          Sidekiq::Client.enqueue(Job::ImportFriends, uid, friend["id"])
          Job::ImportMutualFriends.perform_at(30, uid, friend["id"])
        end
      end
    end
  end
end