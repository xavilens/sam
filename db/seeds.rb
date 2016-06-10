# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
############################################ ROLES ############################################
['registrado', 'baneado', 'inactivo', 'mod', 'admin'].each do |rol|
  Role.find_or_create_by({descripcion: rol})
end

############################################ NIVEL ############################################
['Básico', 'Intermedio', 'Alto', 'Profesional'].each do |level|
  Level.find_or_create_by({nombre: level})
end

############################################ CONOCIMIENTO ############################################
#Conocimientos instrumentos cuerda
['Guitarra', 'Bajo', 'Cantante', 'Cello', 'Violín', 'Contrabajo', 'Viola'].each do |knowledgement|
  Knowledge.find_or_create_by({nombre: knowledgement})
end

#Conocimientos instrumentos de viento metal/madera
['Trombón', 'Saxofón', 'Trompeta', 'Flauta', 'Oboe'].each do |knowledgement|
 Knowledge.find_or_create_by({nombre: knowledgement})
end

#Conocimientos instrumentos de percusión
['Batería', 'Percusión', 'Celesta', 'Marimba'].each do |knowledgement|
 Knowledge.find_or_create_by({nombre: knowledgement})
end

#Conocimientos instrumentos de tecla
['Teclados', 'Piano', 'Acordeón'].each do |knowledgement|
 Knowledge.find_or_create_by({nombre: knowledgement})
end

#Conocimientos vocales
['Cantante', 'Coro'].each do |knowledgement|
 Knowledge.find_or_create_by({nombre: knowledgement})
end

#Conocimientos digitales
['Sintetizador', 'Sampling', 'Secuenciador', 'DJ', 'Produccion', 'Arreglos'].each do |knowledgement|
 Knowledge.find_or_create_by({nombre: knowledgement})
end
