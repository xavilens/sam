class Search
  include ActiveModel::Model

  def initialize fields = {}
    if self.attribute_method? field.to_sym
      public_send("#{field}=",value)
    end
  end

  def initialize_field field, value
    public_send("#{field}=",value)
  end

end
