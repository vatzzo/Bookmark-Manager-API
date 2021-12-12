class ApplicationController < ActionController::API
  include ErrorHandler

  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    @current_user ||= AuthServices::Authorizer.call(headers: request.headers)
  end
end
