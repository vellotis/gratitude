module Gratitude
  class Client
    module Tips

      def current_tips
        self.class.get(tips_url, basic_auth).parsed_response
      end

      def current_tips_total
        current_tips.inject(0) { |total, tip| total + tip["amount"].to_f }
      end

      def update_tips(array_of_hashes_with_usernames_and_amounts)
        self.class.post(
          tips_url, request_payload(array_of_hashes_with_usernames_and_amounts)
          )
      end

      def update_tips_and_prune(array_of_hashes_with_usernames_and_amounts)
        self.class.post(
          tips_url,
          request_payload(array_of_hashes_with_usernames_and_amounts)
            .merge(:query => { :also_prune => "true"})
        )
      end

    private

      def tips_url
        "https://www.gittip.com/#{username}/tips.json"
      end

      def request_payload(array_of_hashes)
        {
          :body => prepared_tips_array(array_of_hashes).to_json,
          :headers => json_header
        }.merge(basic_auth)
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

      def json_header
        { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      end

      def basic_auth
        { :basic_auth => { :username => api_key } }
      end

    end # Tips
  end # Client
end # Gratitude
