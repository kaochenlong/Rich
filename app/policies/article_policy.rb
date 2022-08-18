class ArticlePolicy < ApplicationPolicy

  def create?
    if user.orders.exists?(state: 'paid')
      true
    else
      user.articles.count < 5
    end
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
