# frozen_string_literal: true

require 'rails_helper'

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

describe 'ログインのテスト'  do
  before do
    visit root_path
  end
  it 'トップ画面にルートリンクがあるか'do
    expect(page).to have_link"",href: root_path
  end
  scenario 'トップ画面にaboutリンクがあるか'do
    expect(page).to have_link"",href: about_path
  end
  scenario 'トップ画面に新規登録リンクがあるか'do
    expect(page).to have_link"",href: new_user_registration_path
  end
  scenario 'トップ画面にログインリンクがあるか'do
    expect(page).to have_link"",href: new_user_session_path
  end
  scenario 'トップ画面にゲストログインリンクがあるか'do
    expect(page).to have_link"",href: guests_guest_sign_in_path
  end
end