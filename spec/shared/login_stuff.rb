RSpec.shared_context "with login stuff", shared_context: :metadata do
  def user_login(user)
    visit login_path
    within("#login") do
      fill_in "name", with: user.name
      fill_in "password", with: user.password
    end
    click_button I18n.t('login')
  end

  def login_post(user)
    post '/login', params: { name: user.name, password: user.password }
    request.session[:user_id] = user.id
  end
end

RSpec.configure do |rspec|
  rspec.include_context "with login stuff", include_shared: true
end
