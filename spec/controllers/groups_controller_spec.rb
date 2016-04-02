require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user){create(:user)}
  let(:group_hash){attributes_for(:group)}
  let(:group){create(:group, created_by: user.id)}

  before do
    request.env["HTTP_REFERER"] = "where_i_came_from"
    sign_in user
    group.members << user
    user.group_members.find_by(group_id: group.id).admin!
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

    it "groupを更新する" do
      group_hash.merge!(name: 'hoge', description: 'hogehoge')
      patch :update, id: group, group: group_hash
      group.reload
      expect(group.name).to eq('hoge')
      expect(group.description).to eq('hogehoge')
    end

    it "groupを更新するとshowにリダイレクトされる" do
      group_hash.merge!(name: "redirect!")
      patch :update, id: group, group: group_hash
      expect(response).to redirect_to group_path(group)
    end
  end

  describe "DELETE #destroy" do

    it "groupを削除するとGroup.countが一つ減る" do
      expect{delete :destroy, id: group}.to change(Group, :count).by(-1)
    end

    it "groupを削除するとroot_urlにリダイレクトされる" do
      delete :destroy, id: group
      expect(response).to redirect_to root_url(notice: 'グループを削除しました')
    end
  end

  describe "GET #members" do
    it "idに指定したgroupのmembersを取得する" do
      get :members, id: group
      expect(assigns(:members)).to eq(group.members)
    end

    it "membersテンプレートをレンダリングする" do
      get :members, id: group
      expect(response).to render_template :members
    end
  end

  describe "GET #member_search" do
    it "member_searchテンプレートをレンダリングする" do
      get :member_search, id: group
      expect(response).to render_template :member_search
    end
  end

  describe "PATCH #member_register" do
    it "グループに複数のメンバーを登録する" do
      user_for_register1 = create(:user)
      user_for_register2 = create(:user)
      expect{
        patch :member_register, id: group, members: {email: "#{user_for_register1.email}, #{user_for_register2.email}"}
      }.to change{group.members.size}.by(2)
    end
  end

  describe "PATCH #member_deregister" do
    it "メンバー登録を解除する" do
      expect{
        patch :member_deregister, id: group, member_id: user.id
      }.to change{group.members.size}.by(-1)
    end
  end

  describe "PATCH #member_admin" do
    it "メンバーを管理者として登録する" do
      member = create(:user)
      group.members << member
      expect{
        patch :member_admin, id: group, member_id: member.id
      }.to change{group.group_members.admin.size}.by(1)
    end
  end

  describe "PATCH #member_deadmin" do
    it "メンバーの管理者登録を解除すること" do
      expect{
        patch :member_deadmin, id: group, member_id: user.id
      }.to change{group.group_members.admin.size}.by(-1)
    end
  end

  describe "#member_only" do
    it "メンバー以外のユーザーがアクセスするとForbiddenが発生する" do
      other_user = create(:user)
      sign_in other_user
      expect{get :show, id: group}.to raise_error '403 Forbidden'
    end
  end

  describe "#admin_required" do
    it "管理者以外の管理者でもメンバーでもないユーザーがアクセスするとForbiddenが発生する" do
      other_user = create(:user)
      sign_in other_user
      expect{get :member_search, id: group}.to raise_error '403 Forbidden'
    end

    it "メンバーではあるけど管理者ではないユーザーがアクセスするとForbiddenが発生する" do
      other_user = create(:user)
      sign_in other_user
      group.members << other_user
      expect{get :member_search, id: group}.to raise_error '403 Forbidden'
    end
  end
end
