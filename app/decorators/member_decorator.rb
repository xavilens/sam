class MemberDecorator < Draper::Decorator
  delegate_all

  # Devuelve el nombre de los instrumentos del miembro
  def instruments_names
    instruments_s = ""

    instruments.each do |instrument|
      instruments_s += instrument.name + ", "
    end

    return instruments_s.first(instruments_s.length-2)
  end
  
end
