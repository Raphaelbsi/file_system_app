require 'rails_helper'

RSpec.describe "StoredFiles API", type: :request do
  describe "POST /stored_files" do
    it "envia um arquivo para o diretório" do
      dir = Directory.create!(name: "docs")
      file = fixture_file_upload(Rails.root.join("spec/fixtures/sample.txt"), "text/plain")

      post "/stored_files", params: {
        stored_file: {
          name: "sample.txt",
          directory_id: dir.id,
          file: file
        }
      }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("sample.txt")
    end
  end
end
