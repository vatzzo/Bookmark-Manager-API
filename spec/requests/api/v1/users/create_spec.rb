require "rails_helper"

RSpec.describe "Users API", type: :request do
  let(:call_endpoint) { post "/api/v1/users", params: params }
  let(:params) do
    {
      user: {
        email: email,
        login: login,
        password: password
      }
    }
  end

  describe "#create" do
    let(:email) { "user@example.com" }
    let(:login) { "user_123" }
    let(:password) { "SomePassword.123" }

    it "should create a new user" do
      expect { call_endpoint }
        .to change { User.count }.from(0).to(1)
      expect(response).to have_http_status(:ok)
    end

    context "failure" do
      let(:expected_error) do
        {
          "error" => "user_not_created",
          "status" => 422,
          "message" => kind_of(Array)
        }
      end

      context "password does not contain any special characters" do
        let(:password) { "Password" }

        it "results in error" do
          call_endpoint
          expect(json_response).to include(expected_error)
          expect(json_response["message"][0])
            .to eq("Password  must contain at least one special character")
        end
      end

      context "password does not contain any big letter" do
        before { password.downcase! }

        it "results in error" do
          call_endpoint
          expect(json_response).to include(expected_error)
          expect(json_response["message"][0])
            .to eq("Password  must contain at least one uppercase letter")
        end
      end

      context "wrong email is provided" do
        let(:email) { "wrong-email" }

        it "results in error" do
          call_endpoint
          expect(json_response).to include(expected_error)
          expect(json_response["message"][0])
            .to eq("Email wrong email address.")
        end
      end

      context "wrong login is provided" do
        let(:login) { "short" }

        it "results in error" do
          call_endpoint
          expect(json_response).to include(expected_error)
          expect(json_response["message"][0])
            .to eq("Login is too short (minimum is 6 characters)")
        end
      end
    end
  end
end
