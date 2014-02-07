module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  #displaying errors for each field having validation in model
  def validation_error(message)
    if message.class.to_s == 'Array'
      message = message.join(",")
    end
    return !message.to_s.blank? ? ("<div class='form_error' style='color:red;text-transform:none;width:225px;'>&nbsp;&nbsp;"+message.to_s+"</div>").html_safe : " "
  end

  #displaying errors for devise forms
  def devise_error_messages!
    flash_alerts = []
    error_key = 'errors.messages.not_saved'

    if !flash.empty?
      flash_alerts.push(flash[:error]) if flash[:error]
      flash_alerts.push(flash[:alert]) if flash[:alert]
      flash_alerts.push(flash[:notice]) if flash[:notice]
      error_key = 'devise.failure.invalid'
    end

    return "" if resource.errors.empty? && flash_alerts.empty?
    errors = resource.errors.empty? ? flash_alerts : resource.errors.full_messages

    messages = errors.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t(error_key, :count    => errors.count,
      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
  
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")",:class => "icon-plus")
  end
  
  def set_header(p_type, filename)
    case p_type
    when 'xls'
      headers['Content-Type'] = "application/vnd.ms-excel; charset=UTF-8'"
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      headers['Cache-Control'] = ''

    when 'msword'
      headers['Content-Type'] = "application/vnd.ms-word; charset=UTF-8"
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      headers['Cache-Control'] = ''

    end
  end
end
