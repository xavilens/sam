# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Wrappers are used by the form builder to generate a
  # complete input. You can remove any component from the
  # wrapper, change the order or even add your own to the
  # stack. The options given below are used to wrap the
  # whole input.
  config.wrappers :default, class: :input,
    hint_class: :field_with_hint, error_class: :field_with_errors do |b|
    ## Extensions enabled by default
    # Any of these extensions can be disabled for a
    # given input by passing: `f.input EXTENSION_NAME => false`.
    # You can make any of these extensions optional by
    # renaming `b.use` to `b.optional`.

    # Determines whether to use HTML5 (:email, :url, ...)
    # and required attributes
    b.use :html5

    # Calculates placeholders automatically from I18n
    # You can also pass a string as f.input placeholder: "Placeholder"
    b.use :placeholder

    ## Optional extensions
    # They are disabled unless you pass `f.input EXTENSION_NAME => true`
    # to the input. If so, they will retrieve the values from the model
    # if any exists. If you want to enable any of those
    # extensions by default, you can change `b.optional` to `b.use`.

    # Calculates maxlength from length validations for string inputs
    b.optional :maxlength

    # Calculates pattern from format validations for string inputs
    b.optional :pattern

    # Calculates min and max from length validations for numeric inputs
    b.optional :min_max

    # Calculates readonly automatically from readonly attributes
    b.optional :readonly

    ## Inputs
    b.use :label_input
    b.use :hint,  wrap_with: { tag: :span, class: :hint }
    b.use :error, wrap_with: { tag: :span, class: :error }

    ## full_messages_for
    # If you want to display the full error message for the attribute, you can
    # use the component :full_error, like:
    #
    # b.use :full_error, wrap_with: { tag: :span, class: :error }
  end

  # Wrappers personalizados para tamaños de inputs
  # ref: http://almassapargali.com/2015/01/15/build-bootstrap-forms-with-simple_form-in-ruby-on-rails.html
  1.upto(12) do |col|
    # Wrappers para tamaños de inputs.
    config.wrappers "field_#{col}".to_sym, tag: 'div', class: 'form-group', error_class: 'has-error' do |mdf|
      mdf.use :html5
      mdf.use :placeholder
      mdf.use :label, class: 'col-sm-2 control-label'

      mdf.wrapper tag: 'div', class: "col-sm-#{col}" do |wr|
        wr.use :input, class: 'form-control'
        wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
      end

      # mdf.wrapper tag: 'div', class: "col-sm-#{12-(2+col)}"
      mdf.use :error, wrap_with: { tag: 'span', class: "help-block col-sm-10 col-sm-offset-2" }

      # grid size: total (12) - etiqueta (2) - input (col) - margen (1) = 12-(col+3)
      # mdf.use :error, wrap_with: { tag: 'span', class: "help-block col-sm-10 col-sm-offset-#{12 - (col + 3) + 2}" }
      # mdf.use :error, wrap_with: { tag: 'span', class: "help-block col-sm-10 col-sm-offset-#{(12 - 2 - col) + 2}" }
    end

    # Wrapper para input horizontal
    config.wrappers "horizontal_form_label_#{col}", tag: 'div', class: 'form-group', error_class: 'has-error' do |b|
      b.use :html5
      b.use :placeholder
      b.optional :maxlength
      b.optional :pattern
      b.optional :min_max
      b.optional :readonly
      b.use :label, class: "col-sm-#{col} control-label"

      b.wrapper tag: 'div', class: "col-sm-#{10-col}" do |ba|
        ba.use :input, class: 'form-control'
        ba.use :error, wrap_with: { tag: 'span', class: 'help-block' }
        ba.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
      end
    end

    # Wrappers para inputs multilinea
    config.wrappers "inline_field_#{col}".to_sym, tag: 'div', class: "col-sm-#{col}", error_class: 'has-error' do |ic|
      ic.use :html5
      ic.use :placeholder
      ic.use :label, class: "control-label"

      ic.use :input, class: 'form-control'
      ic.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ic.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end

    config.wrappers "inline_bool_#{col}".to_sym, tag: 'div', class: "col-sm-#{col}", error_class: 'has-error' do |ib|
      ib.use :html5
      ib.optional :readonly

      ib.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :input
        ba.use :label
      end
      ib.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ib.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end

    config.wrappers "inverse_bool_#{col}".to_sym, tag: 'div', class: "form-group text-left col-sm-#{col}", error_class: 'has-error' do |ib|
      ib.use :html5
      ib.optional :readonly

      ib.wrapper tag: 'div', class: 'checkbox' do |ba|
        ba.use :input
        ba.use :label
      end
      ib.use :error, wrap_with: { tag: 'span', class: 'help-block' }
      ib.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
    end

    1.upto(10) do |offset|
      # Wrappers para tamaños de inputs y de offset
      config.wrappers "field_#{col}_offset_#{offset}".to_sym, tag: 'div', class: 'form-group', error_class: 'has-error' do |mdf|
        mdf.use :html5
        mdf.use :placeholder
        mdf.use :label, class: "col-sm-2 col-sm-offset-#{offset} control-label"

        mdf.wrapper tag: 'div', class: "col-sm-#{col}" do |wr|
          wr.use :input, class: 'form-control'
          wr.use :error, wrap_with: { tag: 'span', class: 'help-block' }
          wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
        end
      end

      1.upto(9) do |label|
        # Wrappers para tamaños de inputs y etiquetas.
        config.wrappers "field_#{col}_offset_#{offset}_label_#{label}".to_sym, tag: 'div', class: 'form-group', error_class: 'has-error' do |mdf|
          mdf.use :html5
          mdf.use :placeholder
          mdf.use :label, class: "col-sm-#{label} control-label"

          mdf.wrapper tag: 'div', class: "col-sm-#{col}" do |wr|
            wr.use :input, class: 'form-control'
            wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
          end

          # grid size: total (12) - etiqueta (2) - input (col) - margen (1) = 12-(col+label+1)
          mdf.use :error, wrap_with: { tag: 'span', class: "help-block col-sm-#{12 - (col + label + offset + 1)}" }
        end
      end
    end

    1.upto(9) do |label|
      # Wrappers para tamaños de inputs y etiquetas.
      config.wrappers "field_#{col}_label_#{label}".to_sym, tag: 'div', class: 'form-group', error_class: 'has-error' do |mdf|
        mdf.use :html5
        mdf.use :placeholder
        mdf.use :label, class: "col-sm-#{label} control-label"

        mdf.wrapper tag: 'div', class: "col-sm-#{col}" do |wr|
          wr.use :input, class: 'form-control'
          wr.use :hint,  wrap_with: { tag: 'p', class: 'help-block' }
        end

        # grid size: total (12) - etiqueta (2) - input (col) - margen (1) = 12-(col+label+1)
        mdf.use :error, wrap_with: { tag: 'span', class: "help-block col-sm-#{12 - (col + label + 1)}" }
      end
    end
  end

  # https://github.com/plataformatec/simple_form/wiki/Custom-Wrappers
  config.wrappers :inline_checkbox, :tag => 'div', :class => 'control-group', :error_class => 'error' do |b|
    b.use :html5
    b.wrapper :tag => 'div', :class => 'controls' do |ba|
      ba.wrapper :tag => 'label', :class => 'checkbox' do |bb|
        bb.use :input
        bb.use :label_text
      end
      ba.use :error, :wrap_with => { :tag => 'span', :class => 'help-inline' }
      ba.use :hint,  :wrap_with => { :tag => 'p', :class => 'help-block' }
    end
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :default

  # Define the way to render check boxes / radio buttons with labels.
  # Defaults to :nested for bootstrap config.
  #   inline: input + label
  #   nested: label > input
  config.boolean_style = :nested

  # Default class for buttons
  config.button_class = 'btn'


  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # config.input_mappings = { /count/ => :integer }
  config.input_mappings = { /country/ => :string }

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'
end
