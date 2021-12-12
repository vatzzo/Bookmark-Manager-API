require "rails_helper"

RSpec.describe "Folders API", type: :request do
  let(:call_endpoint) { get "/api/v1/folders", headers: default_headers }
  let!(:user) { create(:default_user) }

  describe "#index" do
    let(:folder) do
      {
        "name" => kind_of(String),
        "created_at" => kind_of(String),
        "updated_at" => kind_of(String)
      }
    end

    before { 2.times { create(:folder, user: user) } }

    it "returns the list of available folders" do
      call_endpoint
      expect(response).to have_http_status(:ok)
      expect(json_response).to be_a(Array)
      expect(json_response.pluck("name")).to match_array(user.folders.pluck(:name))
      expect(json_response).to all(include(folder))
    end
  end
end
