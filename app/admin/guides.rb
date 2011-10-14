ActiveAdmin.register Guide do
  controller.authorize_resource  
  menu :if => proc{ controller.current_ability.can?(:manage, Guide) }
  menu :parent => 'Ressources'
end
