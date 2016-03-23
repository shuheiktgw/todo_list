require 'rails_helper'
include Devise::TestHelpers

RSpec.describe GroupsController, type: :controller do
  let(:group_hash){attributes_for(:group)}
  let(:group){create(:group, created_by: controller.current_user.email)}

  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe "GET #new" do
    it "newテンプレートをレンダリングする" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    login_user
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
    login_user
    it "@groupにリクエストされたグループをアサインする" do
      gourp1 = Group.create_a_new_group(group_hash, controller.current_user)
      group_hash.merge!(name: 'hoge', description: 'hogehoge')
      patch :update, id: group1, group: group_hash
      expect(group1.name).to eq('hoge')
      expect(group1.description).to eq('hogehoge')
    end
  end
end
