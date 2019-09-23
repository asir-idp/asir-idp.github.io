# Configurar una máquina virtual con Windows como Nodo-S

Para que el profesor en el aula pueda verificar la configuración de tu máquina virtual debes:

## 1. Configurarla como Nodo-S

Abrimos **PowerShell** como `Administrador`.

![PowerShell](images/windows-powershell.png)

Copia el siguiente comando, pégalo en el terminal anterior y pulsa ENTER.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/teuton-software/teuton/master/bin/windows_s-node_install.ps1'))
```

Una vez ejecutado el comando, si todo va bien, el resultado debería ser similar al siguiente:

![Resultado de instalación en Windows](images/windows-installation-result.png)

Finalizado este apartado, esta máquina virtual ya sería un Nodo-S de Teuton.

### 2. Configurar la interfaz de red en Adaptador puente

Configuramos la interfaz de red de la máquina virtual en este modo para que ésta esté accesible desde la red del aula. Sigue las instrucciones de este [enlace](../../instalacion/configurar-adaptador-puente-vbox) para configurarlo.

### 3. Establecer la configuración de red de la máquina virtual

Debemos establecer la siguiente configuración de red en la máquina virtual:

| Parámetro de red | Valor        |
| ---------------- | ------------ |
| Dirección IP (ip address) | 10.1.**x**.**y** |
| Máscara de red (netmask) | 255.255.0.0  |
| Puerta de enlace (gateway) | 10.1.0.1     |
| DNS              | 8.8.8.8 |

> Siendo:
>
> -  **x** el número asignado por el profesor a cada alumno
> -  **y** un número del 1 al 254

Cómo establecer la configuración de red en ...

* [Windows 10](https://pureinfotech.com/set-static-ip-address-windows-10/#static_ip_controlpanel_windows10)