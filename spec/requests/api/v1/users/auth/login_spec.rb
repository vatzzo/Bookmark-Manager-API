require "rails_helper"

RSpec.describe "Authentication API", type: :request do
  let(:call_endpoint) { post "/api/v1/auth/login", params: params }
  let(:params) do
    {
      login: login,
      password: password
    }
  end
  let(:login) { user.login }
  let(:password) { "SomePassword.123" }
  let!(:user) { create(:user, password: "SomePassword.123") }

  describe "#login" do
    context "user exsits" do
      it "authenticates the user & returns token" do
        call_endpoint
        expect(json_response["token"]).to be_a(String)
      end
    end

    context "user does not exists" do
      let(:login) { "some_user_123" }

      it "results in not found error" do
        call_endpoint
        expect(json_response).to include(
          {"error"=>"record_not_found", "status"=>404, "message"=>"Couldn't find User"}
        )
      end
    end

    context "wrong password" do
      let(:password) { "wrong_password" }

      it "results in invalid password error" do
        call_endpoint
        expect(json_response).to include(
          {"error"=>"invalid_password", "status"=>401, "message"=>"Wrong password has been passed"}
        )
      end
    end
  end
end
