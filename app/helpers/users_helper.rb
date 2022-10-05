module UsersHelper
  def role_key_options
    User.roles.map { |k, _v| [User.human_attribute_name([:role, k].join('.')), k] }
  end
end
