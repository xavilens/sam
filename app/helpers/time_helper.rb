module TimeHelper
  # Devuelve el tiempo dada una cantidad de segundos
  def seconds_to_time seconds
    time = Time.at(seconds).utc

    if time.hour > 0
      time.strftime("%H:%M:%S")
    else
      time.strftime("%M:%S")
    end
  end

end
