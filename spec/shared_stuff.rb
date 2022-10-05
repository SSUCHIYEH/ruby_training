RSpec.configure do |rspec|
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "with shared stuff", shared_context: :metadata do
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
  rspec.include_context "with shared stuff", include_shared: true
end
