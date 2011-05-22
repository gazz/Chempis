class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin
      can :manage, :all
    elsif
      can :manage, Tournament do |t|
        t.try(:owner) == user
      end
    end
    
  end
  
  
end