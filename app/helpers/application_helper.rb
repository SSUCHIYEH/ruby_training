module ApplicationHelper
  def user_form_url(user)
    if (params[:controller] == 'admin') && (params[:action] == 'new')
      admin_path
    elsif (params[:controller] == 'admin') && (params[:action] == 'edit')
      admin_path(id: user.id)
    else
      users_path
    end
  end

  def user_form_method
    if (params[:controller] == 'admin') && (params[:action] == 'new')
      :post
    elsif (params[:controller] == 'admin') && (params[:action] == 'edit')
      :patch
    else
      :post
    end
  end
end
