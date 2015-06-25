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
        @user_data ||= begin
          resp = access_token.post('https://www.rdio.com/api/1/',
                                   body: {
                                       :method => 'currentUser',
                                       :extras => EXTRAS
                                   })
          MultiJson.decode(resp.body)['result']
        end
      end
    end
  end
end