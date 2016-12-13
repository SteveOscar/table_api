require 'rails_helper'

RSpec.describe TablesController, :type => :controller do
  let(:valid_attributes) {
    {
      table: 20,
      table_id: Us
    }
  }

  let(:valid_table_attributes) {
    {
      time: Time.now,
      location: 'fake@email.com',
      device: 1243
    }
  }
  let(:valid_table_attributes2) {
    {
      name: 'carl',
      email: 'fake@email2.com',
      device: 2375
    }
  }

  let(:valid_session) { {} }

  describe "GET high tables" do
    it "pulls the high tables" do
      Table.create! valid_table_attributes
      table = Table.first.tables.create(table: 22)
      table = Table.last.tables.create(table: 10)
      table = Table.last.tables.create(table: 32)
      table = Table.first.tables.create(table: 9)
      table = Table.first.tables.create(table: 82)
      get :high_tables, {}, valid_session
      result = JSON.parse(response.body)
      expect(result.length).to eq(5)
      expect(result.last['table']).to eq(82)
    end
  end

  describe "POST table" do
    it "creates a high table" do
      Table.create! valid_table_attributes
      post :create, {table_id: Table.first.id, device: Table.first.device, table: 99}, valid_session
      result = JSON.parse(response.body)
      expect(result['table']).to eq(99)
    end
  end

end
