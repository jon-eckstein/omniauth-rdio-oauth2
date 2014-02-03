require 'omniauth-oauth2'
require 'net/http'
require 'multi_json'

module OmniAuth
  module Strategies
    class RdioOauth2 < OmniAuth::Strategies::OAuth2

      option :name, 'rdio_oauth2'

      option :client_options, {
        site: 'https://www.rdio.com/api/1/',
        authorize_url: 'https://www.rdio.com/oauth2/authorize',
        token_url: 'https://www.rdio.com/oauth2/token'
      }

      uid { user_data['key'] }

      info do
        {
            first_name: user_data['firstName'],
            last_name: user_data['lastName'],
            icon: user_data['icon'],
            email: user_data['email'],
            gender: user_data['gender'],
            key: user_data['key']
        }
      end

      extra do
        { :user_data => user_data }
      end

      EXTRAS = 'email,followingUrl,isTrial,artistCount,heavyRotationKey,networkHeavyRotationKey,albumCount,trackCount,username,collectionUrl,playlistsUrl,collectionKey,followersUrl,displayName,isUnlimited,isSubscriber'

      def user_data
        uri = URI('https://www.rdio.com/api/1/')
        res = Net::HTTP.post_form(uri, 'method' => 'currentUser', 'extras' => EXTRAS, 'access_token' => access_token.token)
        @user_data ||= MultiJson.decode(res.body)['result']
      end
    end
  end
end