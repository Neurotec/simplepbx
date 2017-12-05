# README

Simplepbx (metaswitch) es una interfaz de adminstracion remota para multiples Freeswitch(es).

## CARACTERISTICAS

gestion unificada para:

  * Extensiones
  * Grupos
  * Colas 
  * Reporteria (CDR)
  * IVR
  * Grabaciones (streaming)
  
## TODO

  * auto interconexion de Freeswitch para enrutamiento, ejemplo:
    * llamada 111:freeswitch1 debe salir por gateway2:freeswitch, automaticamente enlazar freeswitch
	  y enrutar de freeswitch1 -> gateway2:freeswitch
	  
## FREESWITCH DEPENDENCIAS

Modulos requeridos

  * mod_xml_curl
  * mod_xml_rpc
  * mod_json_cdr
  * mod_http_cache


# INSTALACION

  * clonar repositorio
  * inicializar dependencias **bundle install**
  * configurar **config/database.yml**
  * inicializar base de datos **bundle exec rake db:create; bundle exec rake db:migrate; bundle exec rake db:seed**
  * se crea el usuario por defecto **admin@simplepbx.com:simplepbx**
  
## CONFIGURACION FREESWITCH-MOD-XML-CURL

Configurar el modulo **xml_curl**, reemplazar **localhost:3000** con la URL del servidor instalado:

~~~xml
<binding name="configuration">
  <param name="gateway-url" value="http://localhost:3000/freeswitch_configurator/configuration.xml" bindings="configuration"/>
</binding>
  
<binding name="dialplan">
  <param name="gateway-url" value="http://localhost:3000/freeswitch_configurator/dialplan.xml" bindings="dialplan"/>
</binding>
  
<binding name="directory">
   <param name="gateway-url" value="http://localhost:3000/freeswitch_configurator/directory.xml" bindings="directory"/>
</binding>
~~~

Personalizar el usuario y claves de **xml_rpc** y **event_socket**.

### RECORDING

Para reproducir los archivos almacenados de forma remota.

@TODO asegurar mejor el esquema

**Creamos usuario de sistema simplepbx_recording**


~~~bash
adduser --system simplepbx_recording
mkdir /home/simplepbx_recording/.ssh
ssh-keygen -q -N "" -f /home/simplepbx_recording/id_rsa
chown -R simplepbx_recording:simplepbx_recording /home/simplepbx_recording
~~~

** Editamos sshd_config y agregamos**
con esto restringimos el usuario

~~~bash
Match User simplepbx_recording
 ForceCommand /usr/local/bin/simplepbx_recording
 PasswordAuthentication no
 PermitRootLogin no
 PermitTunnel no
 PermitTTY yes
 PermitUserRC no
~~~

**Creamos comando de reproduccion /usr/local/bin/simplepbx_recording**

@TODO restringir a solo carpeta de reproduccion
~~~bash
#!/bin/rbash

cat $SSH_ORIGINAL_COMMAND
~~~

y asigamos permisos de ejecucion **chmod a+rx /usr/local/bin/simplepbx_recording"

**Instalacion certificado plataforma**

Ingresamos a la plataforma web y damos en *Show* al **Freeswitch** que corresponde a la pbx que estamos instalando,
este certificados lo copiamos a /home/simplepbx_recording/.ssh/authorized_keys.

# TODO

- [ ] Cachear configuracion en maquina local
