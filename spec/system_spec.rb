# frozen_string_literal: true

require 'rails_helper'

describe'モデルのテスト'do
  it "有効なユーザ登録は保存されるか" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  before do
    # 親モデルのインスタンスを生成する
        @user = FactoryBot.create(:user)
    # 親モデルのインスタンスからidを抽出する
        @post = FactoryBot.build(:post, user_id: @user.id)
  end
  it "有効な投稿内容の場合は保存されるか" do
    expect(@post).to be_valid
  end
end