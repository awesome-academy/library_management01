class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, [Book, Author, Category, Publisher, RequestDetail, Request]
      can [:read, :destroy], User
      can :update, User, id: user.id
    else
      can [:index, :show], [Book, Author, Category, Publisher, User]
      can [:create, :update, :destroy], User, id: user.id
      can [:destroy, :index], [Request, RequestDetail]
    end
  end
end
