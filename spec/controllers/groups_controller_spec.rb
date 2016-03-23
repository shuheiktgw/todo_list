require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:group_hash){attributes_for(:group)}
  let(:user){create(:user)}
  let(:group){create(:group, created_by: user.id)}

  before do
    login_user user
    request.env["HTTP_REFERER"] = "where_i_came_from"
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
      get :show, id: group #forbiddenでアクセス出来ない
      expect(assigns(:group)).to eq(group)
    end



  end
end
