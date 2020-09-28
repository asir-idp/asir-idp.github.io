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

Desde un terminal, autoriza esta máquina para usar `ngrok`:

```bash
ngrok authtoken <auth_token>
```

![](ngrok-authtoken.png)

> Debes [darte de alta](https://dashboard.ngrok.com/signup) en la web de `ngrok` y obtener así tu `<auth_token>`.

Luego ejecuta el siguiente comando:

```bash
ngrok tcp 22 -region eu
```

![](ngrok.png)

Y finalmente, proporciona al profesor el siguiente fragmento de texto en formato YAML con tus datos y remplazando los señalados en la imagen (`<address>` y `<port>`):

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

> :warning: El profesor te indicará el medio a través de la cuál deberás entregar este fichero).

Pulsa la combinación de teclas **CTRL + C** para cerrar la conexión de `ngrok`, una vez tu MV haya sido corregida por el profesor.