Instalación de Capistrano en una aplicación 
===========================================

0. Comprobar que ya no exista el capistrano instalado (fichero Capfile o capfile). 

1. Agregar la siguiente línea en el Gemfile:

gem 'capistrano', '~> 3.4.0'

(En este caso en particular al usar versiones antiguas de ruby/rake es mejor dejarlo sin la versión para que Bundler busque la que convenga)


```
bundle install 
```

3. Configuración inicial 

```
bundle exec cap install
```

En este caso al usar Capistrano v2 el comando y su configuración cambia:

```
bundle exec capify .
```

4. Configurar el nombre de la aplicacion, repositorio y servidor en lo en config/deploy*

Para la versión 2 de capistrano, solo hay un fichero, config/deploy.rb - En caso de querer varios entornos hay que buscar un plugin de capistrano que lo permita (ej capistrano-multistage) 

Para la versión 3 de capistrano, crea los ficheros config/deploy.rb, config/deploy/production.rb y config/deploy/staging.rb, poniendo los datos generales en el primero y los especificos de los entornos en los otros.

5. Configurar conexión SSH. 

En ~/.ssh/config configurar lo siguiente: 

Host nombre-del-servidor
    Hostname ip-del-servidor
    Port puerto-del-servidor

Configurar la clave SSH en el ~/.ssh/authorized_keys del usuario al cual nos conectemos. 

Comprobar que funcione la conexión de SSH y aceptar el certificado la primera vez. 

6. Configurar sudoers sin contraseña para la instalación del capistrano. 

Como root

```
visudo
```

Agregar la línea: 

capistrano ALL=(ALL) NOPASSWD: ALL

Una vez haya terminado la configuración inicial es mejor cambiarlo por 

capistrano ALL=(ALL) NOPASSWD: /etc/init.d/unicorn


7. Buscar e instalar librerias peculiares para el deploy que estemos haciendo:

* reinicio de servicios externos como unicorn, resque, god, sphinx, etc
* configuraciones especificas para rails
* configuraciones especificas de RVM 
* etc

Importante que dichas configuraciones o librerias sean compatibles con nuestra versión de capistrano.

8. Probar e ir revisando en el servidor con el comando

```
cap deploy staging
```

O en el caso de capistrano v2 

```
cap deploy:setup 
cap deploy 
```

