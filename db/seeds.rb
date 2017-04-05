# TODO: Más datos?
############################################ ROLES ############################################

['Registrado', 'Baneado', 'Inactivo', 'Mod', 'Admin'].each do |rol|
  Role.find_or_create_by({name: rol})
end

############################################ LEVELS ############################################

['Básico', 'Intermedio', 'Alto', 'Profesional'].each do |level|
  Level.find_or_create_by({name: level})
end

############################################ EVENT_ESTATUSES ############################################

['Abierto', 'Cerrado', 'Buscando participantes'].each do |evStatus|
  EventStatus.find_or_create_by({name: evStatus})
end

############################################ EVENT_TYPES ############################################

['Concierto', 'Festival', 'Acústico'].each do |evType|
  EventType.find_or_create_by({name: evType})
end

############################################ BAND_ESTATUSES ############################################

['Buscando miembros', 'Buscando conciertos', 'Buscando management', 'Buscando local', 'Activo',
  'Inactivo', 'Buscando equipo'].each do |bStatus|
  BandStatus.find_or_create_by({name: bStatus})
end

############################################ MUSICIAN_ESTATUSES ############################################

['Buscando grupo', 'Buscando conciertos', 'Buscando management', 'Activo', 'Inactivo',
  'Buscando equipo'].each do |mStatus|
  MusicianStatus.find_or_create_by({name: mStatus})
end

############################################ KNOWLEDGES ############################################

# Conocimientos instrumentos cuerda
['Guitarra', 'Bajo', 'Cello', 'Violín', 'Contrabajo', 'Viola'].each do |knowledgement|
  Instrument.find_or_create_by({name: knowledgement})
end

# Conocimientos instrumentos de viento metal/madera
['Trombón', 'Saxofón', 'Trompeta', 'Flauta', 'Oboe'].each do |knowledgement|
 Instrument.find_or_create_by({name: knowledgement})
end

# Conocimientos instrumentos de percusión
['Batería', 'Percusión', 'Steeldrum', 'Marimba'].each do |knowledgement|
 Instrument.find_or_create_by({name: knowledgement})
end

# Conocimientos instrumentos de tecla
['Teclado', 'Piano', 'Acordeón'].each do |knowledgement|
 Instrument.find_or_create_by({name: knowledgement})
end

# Conocimientos vocales
['Cantante', 'Coros'].each do |knowledgement|
 Instrument.find_or_create_by({name: knowledgement})
end

# Conocimientos digitales
['Sintetizador', 'DJ'].each do |knowledgement|
 Instrument.find_or_create_by({name: knowledgement})
end

############################################ GENRES ############################################

# Género Electrónica
# ['Electrónica', 'Minimal', 'Techno', 'House', "Drum'n'Bass", 'Dubstep'].each do |genre|
#  Genre.find_or_create_by({name: genre, category: 'Electrónica'})
# end

# Género Rock
# ['Rock', "Rock'n'roll", 'Rockabilly', 'Punk', 'Rock Alternativo', 'Rock Progresivo', 'Post Rock', 'Grunge', 'Garage', 'Hardcore'].each do |genre|
#  Genre.find_or_create_by({name: genre, category: 'Rock'})
# end

# Géneros
['Rock', 'Rockabilly', 'Punk', 'Alternativo', 'Progresivo', 'Post', 'Grunge', 'Garage', 'Hardcore',
  'Electrónica', 'Pop', 'House', 'Techno', 'Metal', 'Trip Hop', 'Chill', 'Rap', 'Ambient', 'Gótico',
  'Blues', 'Jazz', 'Reggae', 'Ska', 'Mestizaje', 'Acid', 'Psicodélico', 'Indie', 'Noise', 'Sinfónico',
  'Minimal', 'Dubstep', 'Trap', 'Folk', 'Funk', "Drum'n'Bass", 'Experimental', 'Doom', 'Speed', 'Math',
  'Disco', 'Flamenco', 'Rumba', 'Bulería', 'Nu', 'New Age', 'Heavy', 'Hard', 'Death', 'Slow', 'Down Tempo'].each do |genre|
 Genre.find_or_create_by({name: genre})
end
