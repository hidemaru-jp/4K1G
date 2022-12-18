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

describe 'トップ画面のテスト', type: :feature do
  before do
    visit root_path
  end
  it 'トップ画面のurlが"/"であるか' do
    expect(current_path).to eq('/') 
  end
  it 'トップ画面にルートリンクがあるか'do
    expect(page).to have_link"",href: root_path
  end
  it 'トップ画面にaboutリンクがあるか'do
    expect(page).to have_link"",href: about_path
  end
  it 'トップ画面に新規登録リンクがあるか'do
    expect(page).to have_link"",href: new_user_registration_path
  end
  it 'トップ画面にログインリンクがあるか'do
    expect(page).to have_link"",href: new_user_session_path
  end
  it 'トップ画面にゲストログインリンクがあるか'do
    expect(page).to have_link"",href: guests_guest_sign_in_path
  end
end

describe '投稿画面のテスト' do
  before do
    # Userモデルのインスタンスを生成する
      @user = FactoryBot.create(:user)
  end
  context 'ユーザーログイン・ログアウトのテスト',type: :feature do
    before do
      visit root_path
    end
    it 'ログインしてログアウトできるか' do
      click_link 'ログイン'
      fill_in 'user[email]',with: @user.email
      fill_in 'user[password]',with: @user.password
      click_button 'ログイン'
      expect(page).to have_current_path user_path(@user)
    end
    it 'ログインに失敗して元の画面に戻るか' do
      click_link 'ログイン'
      fill_in 'user[email]',with: ''
      fill_in 'user[password]',with: ''
      click_button 'ログイン'
      expect(page).to have_current_path new_user_session_path
    end
    it'ログアウトできるか' do
      sign_in @user
      visit user_path(@user)
      expect(page).to have_link"",href: destroy_user_session_path
      find("#logout").click
      expect(page).to have_current_path root_path
    end
  end
  context '投稿一覧画面', type: :feature do
    before do
      visit root_path
      sign_in @user
      visit posts_path
    end
    it '投稿できるか' do
      fill_in 'post[content]', with: 'Hello World'
      click_button '投稿する'
      expect(page).to have_current_path posts_path
      expect(page).to have_link href: post_path(Post.last)
      visit post_path(Post.last)
      expect(page).to have_current_path post_path(Post.last)
      fill_in 'post_comment[comment]', with: 'good morning'
      click_button '投稿する'
      click_link '削除する'
    end
  end
end