module Job
  class ImportFriends
    include Sidekiq::Worker
    sidekiq_options :retry => false

    def perform(uid, person_id)
      user = User.find_by_uid(uid)
      if user
        person = user.client.get_object(person_id)
        if person
          friend = User.create_from_facebook(person)

          # Make them friends
          commands = []
          commands << [:execute_query, "START user=node({user_id}), friend=node({friend_id}) CREATE UNIQUE user-[:FRIENDS]->friend CREATE UNIQUE friend-[:FRIENDS]->user", {:user_id => user.neo_id, :friend_id => friend.neo_id}]
          batch_result = $neo_server.batch *commands
        end
      end
    end

  end
end