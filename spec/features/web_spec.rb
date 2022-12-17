# frozen_string_literal: true

require 'rails_helper'

feature 'ログインのテスト', type: :feature do
  background do
    visit root_path
  end
  scenario 'トップ画面にログインページへのリンクが表示されているか'do
    expect(page).to have_link"",href: new_user_session_path
  end
end