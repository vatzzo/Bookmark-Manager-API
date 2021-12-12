class BaseError < StandardError
  def initialize(error, status, message)
    @error = error
    @status = status
    @message = message
  end

  attr_reader :error, :status, :message
end
