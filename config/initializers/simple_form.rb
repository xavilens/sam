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

      # grid size: total (12) - etiqueta (2) - input (col) - margen (1) = 12-(col+3)
      mdf.use :error, wrap_with: { tag: 'span', class: "help-block col-sm-#{12 - (col + 3)}" }
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
        ba.use :label, class: 'sr-only'
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
      # Wrappers para tamaños de inputs y de etiquetas
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

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # Use :to_sentence to list all errors for each field.
  # config.error_method = :first

  # Default tag used for error notification helper.
  config.error_notification_tag = :div

  # CSS class to add for error notification helper.
  config.error_notification_class = 'error_notification'

  # ID to add for error notification helper.
  # config.error_notification_id = nil

  # Series of attempts to detect a default label method for collection.
  # config.collection_label_methods = [ :to_label, :name, :title, :to_s ]

  # Series of attempts to detect a default value method for collection.
  # config.collection_value_methods = [ :id, :to_s ]

  # You can wrap a collection of radio/check boxes in a pre-defined tag, defaulting to none.
  # config.collection_wrapper_tag = nil

  # You can define the class to use on all collection wrappers. Defaulting to none.
  # config.collection_wrapper_class = nil

  # You can wrap each item in a collection of radio/check boxes with a tag,
  # defaulting to :span.
  # config.item_wrapper_tag = :span

  # You can define a class to use in all item wrappers. Defaulting to none.
  # config.item_wrapper_class = nil

  # How the label text should be generated altogether with the required text.
  # config.label_text = lambda { |label, required, explicit_label| "#{required} #{label}" }

  # You can define the class to use on all labels. Default is nil.
  # config.label_class = nil

  # You can define the default class to be used on forms. Can be overriden
  # with `html: { :class }`. Defaulting to none.
  # config.default_form_class = nil

  # You can define which elements should obtain additional classes
  # config.generate_additional_classes_for = [:wrapper, :label, :input]

  # Whether attributes are required by default (or not). Default is true.
  # config.required_by_default = true

  # Tell browsers whether to use the native HTML5 validations (novalidate form option).
  # These validations are enabled in SimpleForm's internal config but disabled by default
  # in this configuration, which is recommended due to some quirks from different browsers.
  # To stop SimpleForm from generating the novalidate option, enabling the HTML5 validations,
  # change this configuration to true.
  config.browser_validations = false

  # Collection of methods to detect if a file type was given.
  # config.file_methods = [ :mounted_as, :file?, :public_filename ]

  # Custom mappings for input types. This should be a hash containing a regexp
  # to match as key, and the input type that will be used when the field name
  # matches the regexp as value.
  # config.input_mappings = { /count/ => :integer }
  config.input_mappings = { /country/ => :string }

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  # config.wrapper_mappings = { string: :prepend }

  # Namespaces where SimpleForm should look for custom input classes that
  # override default inputs.
  # config.custom_inputs_namespaces << "CustomInputs"

  # Default priority for time_zone inputs.
  # config.time_zone_priority = nil

  # Default priority for country inputs.
  # config.country_priority = nil

  # When false, do not use translations for labels.
  # config.translate_labels = true

  # Automatically discover new inputs in Rails' autoload path.
  # config.inputs_discovery = true

  # Cache SimpleForm inputs discovery
  # config.cache_discovery = !Rails.env.development?

  # Default class for inputs
  # config.input_class = nil

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'checkbox'

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  # config.include_default_input_wrapper_class = true

  # Defines which i18n scope will be used in Simple Form.
  # config.i18n_scope = 'simple_form'
end
