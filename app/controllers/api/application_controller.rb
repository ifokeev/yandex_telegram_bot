class Api::ApplicationController < ActionController::API
  serialization_scope nil

  INCORRECT_PARAMETER_ERRORS = [
    ActionController::ParameterMissing,
    Virtus::CoercionError
  ]

  rescue_from *INCORRECT_PARAMETER_ERRORS, with: :_wrong_parameter

private
  def _wrong_parameter
    _bad_request("Wrong parameter")
  end

  def _not_authorized message = "Not Authorized"
    _error message, 401
  end

  def _not_allowed message = "Forbidden"
    _error message, 403
  end

  def _not_found message = "Not Found"
    _error message, 404
  end

  def _bad_request message = "Bad Request"
    _error message, 400
  end

  def _internal_server_error message = "Internal Server Error"
    _error message, 500
  end

  def _nothing
    render nothing: true, status: 204 and return
  end

  def _success
    render nothing: true, status: 200 and return
  end

  def _error messages, status
    render json: { errors: _normalize(messages) }, status: status and return
  end

  def _normalize messages
    [*messages]
  end
end
