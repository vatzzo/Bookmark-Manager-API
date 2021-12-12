module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from BaseError do |e|
      respond(e.error, e.status, e.message)
    end
  end

  def record_not_found(e)
    respond(:record_not_found, 404, e)
  end

  private

  def respond(error, status, message)
    json = {
      error: error.to_s,
      status: status,
      message: message
    }.as_json

    render json: json, status: status
  end
end
