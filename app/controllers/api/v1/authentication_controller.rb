module Api
  module V1
    class AuthenticationController < ApplicationController
      def login
        token = AuthServices::Authenticator.call(
          login: auth_params[:login],
          password: auth_params[:password]
        )

        render json: { token: token }.as_json, status: :ok
      end

      private

      def auth_params
        params.permit(:login, :password)
      end
    end
  end
end
