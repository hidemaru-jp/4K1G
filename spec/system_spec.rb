# frozen_string_literal: true

require 'rails_helper'
require 'capybara/rspec'

describe'モデルのテスト'do
  before do
    # Userモデルのインスタンスを生成する
      @user = FactoryBot.create(:user)
    # Userモデルのインスタンスからidを抽出する
      @post = FactoryBot.create(:post, user_id: @user.id)
    # UserモデルとPostモデルのインスタンスからidを抽出する
      @post_comment = FactoryBot.build(:post_comment, post_id: @post.id, user_id: @user.id)
  end
  it "有効なユーザ登録は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  it "有効な投稿内容の場合は保存されるか" do
    expect(@post).to be_valid
  end
  it "有効なコメント内容の場合は保存されるか" do
    expect(@post_comment).to be_valid
  end
end

describe 'ログインのテスト'do
  describe'トップ画面のテスト'do
    before do
      visit root_path
    end
  end
  context'表示の確認'do
    it'トップ画面にログインページへのリンクが表示されているか'do
      expect(page).to have_link"",href: new_user_session_path
    end
  end
end