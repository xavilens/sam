# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
############################################ ROLES ############################################
['registrado', 'baneado', 'inactivo', 'mod', 'admin'].each do |rol|
  Role.find_or_create_by({name: rol})
end

############################################ LEVELS ############################################
['Básico', 'Intermedio', 'Alto', 'Profesional'].each do |level|
  Level.find_or_create_by({name: level})
end

############################################ EVENT_ESTATUSES ############################################

# TODO: Más estados de eventos??
['Abierto', 'Cerrado'].each do |evStatus|
  EventStatus.find_or_create_by({name: evStatus})
end

############################################ EVENT_TYPES ############################################

# TODO: Más tipos de eventos
['Concierto', 'Festival', 'Concierto acústico'].each do |evType|
  EventType.find_or_create_by({name: evType})
end

############################################ BAND_ESTATUSES ############################################
['Buscando miembros', 'Buscando conciertos', 'Buscando management', 'Buscando local', 'Activo', 'Inactivo', 'Buscando equipo'].each do |bStatus|
  BandStatus.find_or_create_by({name: bStatus})
end

############################################ MUSICIAN_ESTATUSES ############################################
['Buscando grupo', 'Buscando conciertos', 'Buscando management', 'Activo', 'Inactivo', 'Buscando equipo'].each do |mStatus|
  MusicianStatus.find_or_create_by({name: mStatus})
end

############################################ ACTIVITY_TYPES ############################################

# TODO: Más tipos de actividades
['Post', 'Comment', 'Event', 'Event participant', 'New member', 'Not member', 'New user'].each do |actType|
  ActivityType.find_or_create_by({name: actType})
end
['New knowledge', 'New role', 'Event done', 'Event canceled', 'New sala review', 'New local review'].each do |actType|
  ActivityType.find_or_create_by({name: actType})
end
['New followed', 'New follower'].each do |actType|
  ActivityType.find_or_create_by({name: actType})
end

############################################ KNOWLEDGES ############################################
#Conocimientos instrumentos cuerda
['Guitarra', 'Bajo', 'Cantante', 'Cello', 'Violín', 'Contrabajo', 'Viola'].each do |knowledgement|
  Knowledge.find_or_create_by({name: knowledgement})
end

#Conocimientos instrumentos de viento metal/madera
['Trombón', 'Saxofón', 'Trompeta', 'Flauta', 'Oboe'].each do |knowledgement|
 Knowledge.find_or_create_by({name: knowledgement})
end

#Conocimientos instrumentos de percusión
['Batería', 'Percusión', 'Celesta', 'Marimba'].each do |knowledgement|
 Knowledge.find_or_create_by({name: knowledgement})
end

#Conocimientos instrumentos de tecla
['Teclados', 'Piano', 'Acordeón'].each do |knowledgement|
 Knowledge.find_or_create_by({name: knowledgement})
end

#Conocimientos vocales
['Cantante', 'Coro'].each do |knowledgement|
 Knowledge.find_or_create_by({name: knowledgement})
end

#Conocimientos digitales
['Sintetizador', 'DJ'].each do |knowledgement|
 Knowledge.find_or_create_by({name: knowledgement})
end

############################################ GENRES ############################################
# Género Electrónica
['Electrónica', 'Minimal', 'Techno', 'House', "Drum'n'Bass", 'Dubstep'].each do |genre|
 Genre.find_or_create_by({name: genre, category: 'Electrónica'})
end

# TODO: Género Rock
['Rock', "Rock'n'roll", 'Rockabilly', 'Punk', 'Rock Alternativo', 'Rock Progresivo', 'Post Rock', 'Grunge', 'Garage', 'Hardcore'].each do |genre|
 Genre.find_or_create_by({name: genre, category: 'Rock'})
end

# TODO: Más géneros
