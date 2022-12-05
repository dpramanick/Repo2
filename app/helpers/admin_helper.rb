# frozen_string_literal: true

module AdminHelper
  def require_admin
    return if current_user.is_admin?

    flash[:danger] = 'You must be an admin to perform this action'
    redirect_to root_path
  end
end
