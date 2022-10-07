module ApplicationHelper
  def user_form_url(user)
    if (params[:controller] == 'admin/users') && (params[:action] == 'new')
      '/admin/users'
    elsif (params[:controller] == 'admin/users') && (params[:action] == 'edit')
      admin_user_path(id: user.id)
    else
      users_path
    end
  end

  def user_form_method
    if (params[:controller] == 'admin/users') && (params[:action] == 'new')
      :post
    elsif (params[:controller] == 'admin/users') && (params[:action] == 'edit')
      :patch
    else
      :post
    end
  end
end
