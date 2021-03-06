module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate_request, only: :create

      def create
        UserServices::CreateUser.call(
          email: user_params[:email],
          login: user_params[:login],
          password: user_params[:password]
        )
        head :ok
      end

      private

      def user_params
        params.require(:user).permit!
      end
    end
  end
end
