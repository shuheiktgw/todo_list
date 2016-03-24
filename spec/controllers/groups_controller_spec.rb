require 'rails_helper'
include Devise::TestHelpers

RSpec.describe GroupsController, type: :controller do
  let(:user){create(:user)}
  let(:group_hash){attributes_for(:group)}
  let(:group){create(:group, created_by: user.id)}

  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
    sign_in user
  end

  describe "GET #new" do
    it "newテンプレートをレンダリングする" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "新しいグループをデータベースに登録する" do
      expect{
        post :create, group: group_hash
      }.to change(Group, :count).by(1)
    end

    it "グループの作成に成功すると,articles#showへリダイレクトする" do
      post :create, group: group_hash
      expect(response).to redirect_to group_path(Group.last)
    end
  end

  describe "PATCH #update" do

    it "@groupにリクエストされたグループをアサインする" do
      group.members << user
      user.group_members.find_by(group_id: group.id).admin!
      group_hash.merge!(name: 'hoge', description: 'hogehoge')
      patch :update, id: group, group: group_hash
      group.reload
      expect(group.name).to eq('hoge')
      expect(group.description).to eq('hogehoge')
    end
  end
end
