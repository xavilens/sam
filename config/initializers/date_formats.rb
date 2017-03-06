# Configura las salidas de las fechas con formato español
# http://railsdynamics.blogspot.com.es/2011/09/cambiando-el-formato-de-fecha.html
Time::DATE_FORMATS[:default] = lambda { |time| I18n.l(time) }
Date::DATE_FORMATS[:default] = lambda { |date| I18n.l(date) }
