module Api
  module V1
    class FoldersController < ApplicationController
      def index
        render json: folders, status: :ok
      end

      private

      def folders
        @folders ||= current_user.folders
      end
    end
  end
end
