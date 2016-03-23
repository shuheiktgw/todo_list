require 'rails_helper'

RSpec.describe TasksController, :type => :controller do
  let(:task){create(:task)}
  let(:task_hash){attributes_for(:task)}
  let(:user){create(:user)}


  before do
    login_user user
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    it "新しいタスクをデータベースに登録する" do
      expect{post :create, task: task_hash}.to change(Task, :count).by(1)
      response.should redirect_to "where_i_came_from"
    end
  end

  describe 'DELETE #destroy' do
    it 'タスクを削除する' do
      task = create(:task)
      expect{delete :destroy, id: task.id}.to change(Task, :count).by(-1)
    end
  end
end