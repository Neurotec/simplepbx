# README

Simplepbx es una interfaz de adminstracion remota para multiples Freeswitch(es).

## FREESWITCH DEPS

Modulos requeridos
  * mod_xml_curl
  * mod_xml_rpc
  * mod_json_cdr
  * mod_http_cache


# INSTALACION

  * clonar repositorio
  * configurar **config/database.yml**
  * inicializar con **rake db:create;rake db:migrate; rake db:seed**
  * se crea el usuario por defecto **admin@simplepbx.com:simplepbx**
  
## CONFIGURACION PBX

Para activar la pbx, se debe activar los modulos:
  * mod_xml_curl
  * mod_xml_rpc
  * mod_json_rpc
  
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

@TODO el esquema es inseguro. 

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

**Creamos comand de reproduction /usr/local/bin/simplepbx_recording**

@TODO restringir a solo carpeta de reproduccion
~~~bash
#!/bin/rbash

cat $SSH_ORIGINAL_COMMAND
~~~

y asigamos permisos de ejecucion **chmod a+rx /usr/local/bin/simplepbx_recording"

**Instalacion certificado plataforma**

Ingresamos a la plataforma web y damos en *Show* al **Freeswitch** que corresponde a la pbx que estamos instalando,
este certificados lo copiamos a /home/simplepbx_recording/.ssh/authorized_keys.


## Conceptos

Para el proceso de creacion de *dialplans* en terminos de Freeswitch, divido un dial plan en:
  - Condicion de entrada
  - Perfil(es)
  - Enrutamiento/bridge

### OutboundRoute

Asocia los modelos que son enrutables/bridge.

#### Routable (concern)

Todo modelo que puede ser enrutable/bridge debe incluir el concer Routable,
y crear el metodo **routable_name** que retorna un string de como ven este modelo en la lista de seleccion.

### User

Usuario que administra una pbx.

### Endpoint

o conocido SipProfile.

### Inbound

Es una cuenta para troncales de ingreso.
Es una cuenta en **directory** o un acceso permitido por los **acl**.

### Outbound

Es una cuenta para troncales de salida, o en freeswitch gateway.

### Extension

Cuenta de usuario o extensiones de acceso.

#### ExtensionProfile

Define el perfile para las extension, el perfil por defecto es *Phone*
que son las acciones generales, tranferecia, captura, el **features** de Freeswitch.

### DestinationProfile 

Agrupa una condicion y una serie de acciones para ser evaluadas.

#### DestinationProfileActions (internal)

Define las acciones

### Queue (controlador)

define un *DestinationProfile* y una serie de *DestinationProfileAction* con el proposito de usar una fifo.

### Group (controlador)

define un *DestinationProfile* y una serie de *DestinationProfileAction* con el proposito de hacer un grupo a llamada

### EndpointRoute

determina las acciones a ejecutar segund el **endpoint**.


# IDEA CALL QUEUE

g scaffold CallQueue endpoint:references name:string destination:number
g scaffold CallQueueExtension call_queue:references extension:references enable:boolean


# TODO

[] - Cachear configuracion en maquina local
