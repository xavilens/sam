class TimePickerInput < DatePickerInput
  def input(wrapper_options)
    super(wrapper_options, "datetimepicker")
  end

  private

  def input_button
    template.content_tag :span, class: 'input-group-addon' do
      template.content_tag :span, '', class: 'fa fa-clock-o'
    end
  end

  def display_pattern
    I18n.t('timepicker.dformat', default: '%R')
  end

  def picker_pattern
    I18n.t('timepicker.pformat', default: 'HH:mm')
  end

  def date_options
    {
        locale: I18n.locale.to_s,
        format: 'LT'
    }
  end
end
