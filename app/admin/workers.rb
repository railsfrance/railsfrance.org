ActiveAdmin.register Worker do
  controller.authorize_resource
  menu :if => proc{ controller.current_ability.can?(:manage, Worker) }
  menu :parent => 'Ressources'
end
