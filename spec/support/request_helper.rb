module RequestHelper
  def json_response
    JSON.parse(response.body)
  end

  def default_token
    default_headers["Authorization"]
  end

  def default_headers
    {
      "Authorization" => "eyJhbGciOiJIUzI1NiJ9.eyJsb2dpbiI6ImRlZmF1bHRfdXNlciIsImVtYWlsIjoiZGVmYXVsdF91c2VyQGV4YW1wbGUuY29tIn0.kc_SdE0Zh-_dHw4j9ljl1V6VjKB2IsJeDnQngRG7yog",
      "Content-Type" => "application/json"
    }
  end
end
