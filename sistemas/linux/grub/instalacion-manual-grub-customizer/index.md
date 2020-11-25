# Instalación manual de `grub-customizer`

Guía para instalar manualmente `grub-customizer` en una distribución GNU/Linux basada en Debian (Ubuntu, LinuxMint, ...):

1. Instalar el paquete `hwinfo` necesario para poder instalar `grub-customizer`.

    ```bash
    sudo apt install -y hwinfo
    ```

2. Descargar el fichero DEB correspondiente al paquete de instalación de `grub-customizer`:

   ```bash
    wget http://ppa.launchpad.net/danielrichter2007/grub-customizer/ubuntu/pool/main/g/grub-customizer/grub-customizer_5.1.0-0ubuntu1~ppa1b_amd64.deb
   ```

3. Instalar el paquete que acabamos de descargar:

	```bash
	sudo dpkg -i grub-customizer_5.1.0-0ubuntu1~ppa1b_amd64.deb
	```
	
Y listo, ¡¡¡de nada!!!