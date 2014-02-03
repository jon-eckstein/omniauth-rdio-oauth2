require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Rdio2 < OmniAuth::Strategies::OAuth2

      option :name, 'rdio_oauth2'

      option :client_options, {
        site: 'https://www.rdio.com',
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

        access_token.options[:mode] = :query
        @user_data ||=
          begin
            json = access_token.post('https://www.rdio.com/api/1/',
                                       method: 'currentUser',
                                       extras: EXTRAS).body
            MultiJson.decode(json)['result']
          end
      rescue ::Errno::ETIMEDOUT
        raise ::TimeoutError::Error
      end
    end
  end
end