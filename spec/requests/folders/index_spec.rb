require "rails_helper"

RSpec.describe "Folders API", type: :request do
  let(:call_endpoint) { get "/api/v1/folders", headers: default_headers }
  let!(:user) { create(:default_user) }

  describe "#index" do
    let(:folder) do
      {
        "name" => kind_of(String),
        "created_at" => kind_of(String),
        "updated_at" => kind_of(String),
        "items" => kind_of(Array)
      }
    end

    context "when there are no folders" do
      it "returns an empty list" do
        call_endpoint
        expect(response).to have_http_status(:ok)
        expect(json_response["folders"]).to be_empty
      end
    end

    context "without folder items" do
      before do
        2.times { create(:folder, user: user) }
      end

      it "returns the list of available folders" do
        call_endpoint
        expect(response).to have_http_status(:ok)
        expect(json_response["folders"]).to be_a(Array)
        expect(json_response["folders"].pluck("name")).to match_array(user.folders.pluck(:name))
        expect(json_response["folders"]).to all(include(folder))
      end
    end

    context "with folder items" do
      let(:item) do
        {
          "title" => kind_of(String),
          "description" => kind_of(String),
          "url" => kind_of(String)
        }
      end

      before do
        2.times { create(:folder, :with_folder_items, user: user, amount: 3) }
      end

      it "returns the list of available folders & their items" do
        call_endpoint
        expect(response).to have_http_status(:ok)
        expect(json_response["folders"]).to be_a(Array)
        expect(json_response["folders"].pluck("name")).to match_array(user.folders.pluck(:name))
        expect(json_response["folders"]).to all(include(folder))
        items = json_response["folders"].pluck("items").flatten
        expect(items).to all(include(item))
      end
    end
  end
end
