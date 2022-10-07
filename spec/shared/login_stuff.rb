RSpec.shared_context "with user stuff", shared_context: :metadata do
  let(:btn_create) { I18n.t('helpers.submit.create') }
  let(:btn_update) { I18n.t('helpers.submit.update') }
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

  def sign_up_user(name, password)
    within("#form_user") do
      fill_in "user_name", with: name
      fill_in "user_password", with: password
      select normal, from: "user_role"
    end
  end
end

RSpec.configure do |rspec|
  rspec.include_context "with user stuff", include_shared: true
end
