ActiveAdmin.register User do
  controller.authorize_resource
  menu :if => proc{ controller.current_ability.can?(:manage, User) }
  index do
    column :username
    column :email
    column :role
    column :current_sign_in_at
    column :last_sign_in_at
    default_actions
  end  
end
