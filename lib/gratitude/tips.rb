module Gratitude
  class Client
    module Tips

      def current_tips
        self.class.get(tips_url, { :basic_auth => authorization }).parsed_response
      end

      def current_tips_total
        current_tips.inject(0) { |total, tip| total + tip["amount"].to_f }
      end

      def update_tips(array_of_hashes_with_usernames_and_amounts)
        self.class.post(tips_url,
        {
          :body => prepared_tips_array(array_of_hashes_with_usernames_and_amounts).to_json,
          :basic_auth => authorization,
          :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
          })
      end

      def update_tips_and_prune(array_of_hashes_with_usernames_and_amounts)
        self.class.post(tips_url,
        {
          :body => prepared_tips_array(array_of_hashes_with_usernames_and_amounts).to_json,
          :basic_auth => authorization,
          :query => { :also_prune => "true"},
          :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
          })
      end

      def tips_url
        "https://www.gittip.com/#{username}/tips.json"
      end

      def authorization
        { :username => api_key }
      end

      def tip_hash_based_upon(username, amount)
        { "amount" => "#{amount}", "platform" => "gittip", "username" => "#{username}" }
      end

      def prepared_tips_array(array_of_hashes_with_usernames_and_amounts)
        prepared_array = []
        array_of_hashes_with_usernames_and_amounts.each do |hash|
          username = hash[:username] || hash["username"]
          amount = hash[:amount] || hash["amount"]
          prepared_array << tip_hash_based_upon(username, amount)
        end
        prepared_array
      end

    end # Tips
  end # Client
end # Gratitude