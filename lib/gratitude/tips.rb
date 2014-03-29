module Gratitude
  class Client
    module Tips

      def current_tips
        faraday.get(tips_url).body
      end

      def current_tips_total
        current_tips.inject(0) { |total, tip| total + tip["amount"].to_f }
      end

      def update_tips(array_of_hashes_with_usernames_and_amounts)
        faraday.post do |request|
          payload_for(request, array_of_hashes_with_usernames_and_amounts)
        end.body
      end

      def update_tips_and_prune(array_of_hashes_with_usernames_and_amounts)
        faraday.post do |request|
          payload_for(request, array_of_hashes_with_usernames_and_amounts)
          request.params = { :also_prune => "true"}
        end.body
      end

    private

      def tips_url
        "/#{username}/tips.json"
      end

      def payload_for(request, array_of_hashes)
        request.url(tips_url)
        request.body = prepared_tips_array(array_of_hashes).to_json
      end

      def prepared_tips_array(array_of_hashes)
        array_of_hashes.each_with_object([]) do |hash, array|
          username = hash[:username] || hash["username"]
          amount = hash[:amount] || hash["amount"]
          array << tip_hash_based_upon(username, amount)
        end
      end

      def tip_hash_based_upon(username, amount)
        {
          "amount" => "#{amount}",
          "platform" => "gittip",
          "username" => "#{username}"
        }
      end

    end # Tips
  end # Client
end # Gratitude
