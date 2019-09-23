# Configurar una máquina virtual con GNU/Linux como Nodo-S

Para que el profesor en el aula pueda verificar la configuración de tu máquina virtual debes:

## 1. Configurarla como Nodo-S

Abrir un terminal (Ctrl + Alt + T).

![Terminal GNU/Linux](images/linux-bash.png)

Copia el siguiente comando, pégalo en el terminal y pulsa ENTER.

```bash
wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/bin/linux_s-node_install.sh | sudo bash
```

Una vez ejecutado el comando, si todo va bien, el resultado debería ser similar al siguiente:

![Resultado de instalación en GNU/Linux](images/linux-installation-result.png)

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

* [Ubuntu 18.04.1 LTS](https://tecadmin.net/change-ip-address-on-ubuntu-18-04-desktop/)