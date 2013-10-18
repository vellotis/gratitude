module Gratitude
  class Client
    module Tips

      def tips_url
        "https://www.gittip.com/#{username}/tips.json"
      end

      def authorization
        { :basic_auth => { :username => api_key } }
      end

      def current_tips
        self.class.get(tips_url, authorization).parsed_response
      end

    end # Tips
  end # Client
end # Gratitude