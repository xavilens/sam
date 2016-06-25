# README

## Configuración mínima para probar la aplicación en otro sistema:

### Asegurate de tener instalados los siguientes:
- Ruby 2.3
- Rails 4.2.6
- MySQL 5.5.49

### Pasos
1. Configura los datos de acceso a la BDD en la ruta `/config/database.yml`
2. Instalar las gemas utilizadas con `bundle install`
3. Crear la base de datos con `rake db:create`
4. Popular la base de datos con `rake db:reset`
