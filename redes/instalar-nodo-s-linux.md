# Configurar nuestra máquina virtual con GNU/Linux como Nodo-S

Para que el profesor en el aula pueda verificar la configuración de tu máquina virtual debes:

1. Configurarla como Nodo-S.
2. Darle acceso desde la red local del aula.

## Configurar como Nodo-S

1. Abrir un terminal (Ctrl + Alt + T).

   ![Terminal GNU/Linux](images/terminal-linux.png)

2. Copia el siguiente comando, pégalo en el terminal y pulsa ENTER.

   ```bash
   wget -qO- https://raw.githubusercontent.com/teuton-software/teuton/master/bin/linux_s-node_install.sh | sudo bash
   ```

   Quedando del siguiente modo:

   ![Install s-node command](images/install-node-s-command.png)

3. Una vez ejecutado el comando, si todo va bien, el resultado debería ser el siguiente:

   ![1569241731248](D:\Users\fvarrui\Documents\GitHub\IDP\teuton\images\s-node-installation-result.png)

Finalizado este apartado, esta máquina virtual ya sería un Nodo-S de Teuton.

## Dar acceso a la máquina desde la red local

### Configurar la máquina virtual en Adaptador puente

1. Abrir la configuración de la máquina virtual en VirtualBox:

	![Configurar la MV en VBox](images/configurar-mv-vbox.png)

2. Seleccionar la pestaña **Red** del panel de la izquierda, elegir **Adaptador puente** en el desplegable **Conectado a**, y pulsar **Aceptar**.

   ![Configurar Adaptador puente en VBox](images/configurar-adaptadorpuente-vbox.png)

   > Si disponemos de más de una interfaz de red física (como puede ocurrir en un portátil, que tenemos wifi y cable), en el desplegable **Nombre** podemos elegir a través de qué interfaz se conectará nuestra máquina virtual a la red física.

Con esto ya estaría la máquina virtual conectada a la misma red física que la máquina real.

### Establecer la configuración de red de la máquina virtual

> El siguiente proceso se explica en un Ubuntu 18.04, pero debe ser similar en otras distribución de GNU/Linux.

Debemos establecer la siguiente configuración de red en la máquina virtual:

| Parámetro        | Valor                                                        |
| ---------------- | ------------------------------------------------------------ |
| Dirección IP     | **10.1.x.y** (siendo **x** el número que te ha asignado el profesor e **y** un número del 1 al 254). |
| Máscara de red   | 255.255.0.0                                                  |
| Puerta de enlace | 10.1.0.1                                                     |
| DNS              | 8.8.8.8                                                      |

1. Abrimos el panel de "Configuración" del sistema y seleccionamos "Red".

	![1569244014856](D:\Users\fvarrui\AppData\Roaming\Typora\typora-user-images\1569244014856.png)
	
3. 

