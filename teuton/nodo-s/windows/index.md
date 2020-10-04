# Configurar una MV con Windows como Nodo-S

Para que el profesor pueda verificar la configuración de tu máquina virtual (MV) con Windows mediante **teuton** debes hacer lo siguiente:

## 1. Configurar la MV como Nodo-S

Abre **PowerShell** como `Administrador`.

![PowerShell](windows-powershell.png)

Copia el siguiente comando, pégalo en el terminal y pulsa ENTER.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/asir-idp/asir-idp.github.io/master/teuton/nodo-s/windows/windows_s-node_install.ps1'))
```

Una vez ejecutado el comando, si todo va bien, el resultado debería ser similar al siguiente:

![Resultado de instalación en Windows](windows-installation-result.png)

Finalizado este apartado, esta MV ya es un Nodo-S para **teuton**.

## 2. Hacer la máquina accesible al profesor

En este punto se dan dos posibles situaciones: si tu MV se encuentra a) **dentro del aula** o b) **en el exterior** (en tu casa, por ejemplo).

### a) Dentro del aula

Primero [configuramos la interfaz de red de la MV en **Adaptador puente**](../../virtualizacion/virtualbox/configurar-red-en-adaptador-puente) para que sea accesible desde la red del aula.

Luego averigua la dirección IP de tu MV de alguno de los siguientes modos:

1. Abre un terminal y ejecuta el comando `ipconfig`.

2. En la esquina inferior derecha de VBox se encuentra un icono que muestra la actividad de red de la MV, si mantenemos el puntero del ratón sobre dicho icono, nos mostrará la dirección IP:

	![](vbox-ip.png)

Finalmente, proporciona al profesor un fichero en formato YAML con el siguiente contenido, indicando tus datos y remplazando `<address>` por tu dirección IP:

```yaml
- :tt_members: <tu nombre completo>
  :tt_moodle_id: <tu email de EVAGD>
  :host1_ip: <address>
  :host1_port: 22
  :tt_skip: false
```

Por ejemplo:

```yaml
- :tt_members: Francisco Vargas Ruiz
  :tt_moodle_id: mi@email.es
  :host1_ip: 192.168.0.5
  :host1_port: 22
  :tt_skip: false
```

> El profesor te indicará el medio a través del cuál deberás entregar este fichero.

### b) En el exterior

Primero, debes [darte de alta](https://dashboard.ngrok.com/signup) en la web de `ngrok` y obtener así tu `<auth_token>`.

![](authtoken.png)

Luego, desde un terminal, autoriza esta máquina para usar `ngrok`:

```bash
ngrok authtoken <auth_token>
```

![](ngrok-authtoken.png)

A continuación, también desde un terminal, ejecuta el siguiente comando:

```bash
ngrok tcp 22 -region eu
```

![](ngrok.png)

Y finalmente, proporciona al profesor un fichero en formato YAML con el siguiente contenido, indicando tus datos y remplazando los señalados en la imagen (`<address>` y `<port>`):

```yaml
- :tt_members: <tu nombre completo>
  :tt_moodle_id: <tu email de EVAGD>
  :host1_ip: <address>
  :host1_port: <port>
  :tt_skip: false
```

Por ejemplo:

```yaml
- :tt_members: Francisco Vargas Ruiz
  :tt_moodle_id: mi@email.es
  :host1_ip: 2.tcp.eu.ngrok.io
  :host1_port: 10746
  :tt_skip: false
```

> El profesor te indicará el medio a través dela cuál deberás entregar este fichero.

Pulsa la combinación de teclas **CTRL + C** para cerrar la conexión de `ngrok`, una vez tu MV haya sido corregida por el profesor.