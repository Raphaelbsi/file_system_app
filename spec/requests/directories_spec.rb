require 'rails_helper'

RSpec.describe "Directories API", type: :request do
  describe "POST /directories" do
    it "cria um diretório raiz" do
      post "/directories", params: { directory: { name: "root" } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["name"]).to eq("root")
    end

    it "cria um subdiretório" do
      parent = Directory.create!(name: "parent")

      post "/directories", params: { directory: { name: "child", parent_id: parent.id } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["parent_id"]).to eq(parent.id)
    end
  end

  describe "GET /directories/:id" do
    it "retorna um diretório com subdiretórios e arquivos" do
      dir = Directory.create!(name: "docs")
      get "/directories/#{dir.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["name"]).to eq("docs")
    end
  end
end
