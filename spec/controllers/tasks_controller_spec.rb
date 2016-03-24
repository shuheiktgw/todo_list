require 'rails_helper'
include Devise::TestHelpers

RSpec.describe TasksController, :type => :controller do
  let(:task){create(:task)}
  let(:task_hash){attributes_for(:task)}
  let(:user){create(:user)}


  before do
    sign_in user
    user.tasks << task
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    it "新しいタスクを登録すると元のページにリダイレクされる" do
      expect{post :create, task: task_hash}.to change{user.tasks.count}.by(1)
      response.should redirect_to "where_i_came_from"
    end
  end

  describe 'PATCH #done_registration' do
    it "タスクのステータスをdoneに変更する" do
      expect{patch :done_registration, checked_id: [task.id]}.to change{task.reload.status}.from('not_yet').to('done')
    end

    it "複数のタスクのステータスをdoneにする" do
      task1 = create(:task)
      task2 = create(:task)
      user.tasks << task1
      user.tasks << task2
      expect{patch :done_registration, checked_id: [task.id, task1.id, task2.id]}.to change{task.reload.status}.from('not_yet').to('done')
    end

    it "タスクが選択されていなければ元のページにリダイレクされる" do
      patch :done_registration, checked_id: nil
      expect(response).to redirect_to "where_i_came_from"
    end
  end

  describe 'DELETE #destroy' do
    it 'タスクを削除する' do
      expect{delete :destroy, id: task.id}.to change(Task, :count).by(-1)
    end
  end
end