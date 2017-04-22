class DatePickerInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options, picker_class = nil)
    picker_class ||= "datepicker"

    set_html_options(picker_class)
    set_value_html_option

    template.content_tag :div, class: "input-group date #{picker_class}" do
      input = super(wrapper_options) # leave StringInput do the real rendering
      input + input_button
    end
  end

  def input_html_classes
    super.push ''   # 'form-control'
  end

  private

  def input_button
    template.content_tag :span, class: 'input-group-addon' do
      template.content_tag :span, '', class: 'fa fa-calendar'
    end
  end

  def set_html_options(datepicker = nil)
    input_html_options[:type] = 'text'
    input_html_options[:data] ||= {}
    input_html_options[:data].merge!(date_options: date_options)

    if datepicker
      input_html_options[:class] ||= ""
      input_html_options[:class].push("#{datepicker}")
    end
  end

  def set_value_html_option
    return unless value.present?
    input_html_options[:value] ||= value
    # input_html_options[:value] ||= I18n.localize(value, format: display_pattern)
  end

  def value
    object.send(attribute_name) if object.respond_to? attribute_name
  end

  def display_pattern
    I18n.t('datepicker.dformat', default: '%d/%m/%Y')
  end

  def picker_pattern
    I18n.t('datepicker.pformat', default: 'DD/MM/YYYY')
  end

  def date_view_header_format
    I18n.t('dayViewHeaderFormat', default: 'MMMM YYYY')
  end

  def date_options_base
    {
        locale: I18n.locale.to_s,
        format: picker_pattern,
        dayViewHeaderFormat: date_view_header_format
    }
  end

  def date_options
    custom_options = input_html_options[:data][:date_options] || {}
    date_options_base.merge!(custom_options)
  end

end
