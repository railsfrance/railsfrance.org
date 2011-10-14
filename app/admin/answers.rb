ActiveAdmin.register Answer do
  controller.authorize_resource
  menu :parent => 'Question'
end
