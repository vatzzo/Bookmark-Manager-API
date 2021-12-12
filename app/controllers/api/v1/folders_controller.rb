module Api
  module V1
    class FoldersController < ApplicationController
      def index
        # TODO: add folders namespace to the beggining of the response
        render json: folders, each_serializer: FolderSerializer, status: :ok
      end

      private

      def folders
        @folders ||= current_user.folders
      end
    end
  end
end
