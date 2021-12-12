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

    context "invalid password" do
      context "password does not contain any special characters" do
        let(:password) { "Password" }

        it "should raise an error" do
          expect { call_endpoint }.to raise_error
        end
      end

      context "password does not contain any big letter" do
        before { password.downcase! }

        it "should raise an error" do
          expect { call_endpoint }.to raise_error
        end
      end
    end

    context "wrong email is provided" do
      let(:email) { "wrong-email" }

      it "should raise an error" do
        expect { call_endpoint }.to raise_error
      end
    end

    context "wrong login is provided" do
      let(:login) { "short" }

      it "should raise an error" do
        expect { call_endpoint }.to raise_error
      end
    end
  end
end
