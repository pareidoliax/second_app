class CommentPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def destroy?
    user.present? && (user.role?(:admin) || user.role?(:moderator) || record.user == user)
  end
end