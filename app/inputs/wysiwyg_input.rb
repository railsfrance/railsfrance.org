class WysiwygInput < SimpleForm::Inputs::Base
  def input
    @builder.template.render :file => Rails.root.join("app", "views", "inputs", "wysiwyg"), :locals => {:builder => @builder, :name => attribute_name}
  end
end
