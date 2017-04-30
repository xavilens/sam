class MemberDecorator < Draper::Decorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?
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
