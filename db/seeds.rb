# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['registrado', 'baneado', 'inactivo', 'mod', 'admin'].each do |rol|
  Rol.find_or_create_by({descripcion: rol})
end
