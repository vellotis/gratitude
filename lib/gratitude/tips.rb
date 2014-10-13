# encoding: utf-8

module Gratitude
  class Client
    module Tips
      def current_tips
        response = faraday.get(tips_path)
        raise_any_errors_based_upon(response)
        response.body
      end

      def current_tips_total
        current_tips.inject(0) { |total, tip| total + tip["amount"].to_f }
      end

      def update_tips(array_of_hashes_with_usernames_and_amounts)
        post_tips_to_gratipay(array_of_hashes_with_usernames_and_amounts)
      end

      def update_tips_and_prune(array_of_hashes_with_usernames_and_amounts)
        post_tips_to_gratipay(
          array_of_hashes_with_usernames_and_amounts, prune: true
        )
      end

      private

      def post_tips_to_gratipay(array_of_hashes, options = {})
        response = faraday_post_response(array_of_hashes, options)
        raise_any_errors_based_upon(response)
        response.body
      end

      def faraday_post_response(array_of_hashes, options = {})
        faraday.post do |request|
          request.url(tips_path)
          request.body = prepared_tips_array(array_of_hashes).to_json
          request.params = { also_prune: "true" } if options[:prune] == true
        end
      end

      def tips_path
        "/#{username}/tips.json"
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
          "platform" => "gratipay",
          "username" => "#{username}"
        }
      end

      def raise_any_errors_based_upon(response)
        if response.body.is_a?(Hash) && response.body.key?("error_code")
          raise AuthenticationError
        elsif usernames_with_errors(response.body).size > 0
          raise TipUpdateError, usernames_with_errors(response.body)
        end
      end

      def usernames_with_errors(response_body)
        response_body.each_with_object([]) do |user_tip_response, array|
          if user_tip_response.key?("error")
            array << user_tip_response["username"]
          end
        end
      end
    end # Tips
  end # Client
end # Gratitude
