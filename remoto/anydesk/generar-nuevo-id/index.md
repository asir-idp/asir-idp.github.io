# Generar un nuevo ID para AnyDesk

Al clonar PCs con AnyDesk instalado, ocurre que todos esos PCs clonados tienen el mismo ID (dirección) de AnyDesk, lo que supone un problema a la hora de conectar de forma remota a los mismos.

Una solución provisional sería finalizar AnyDesk desde el área de notificaciones de la barra de tareas y volver a iniciarlo. Pero cuando reiniciamos el PC, volvemos a tener el ID original, repetido.

Podemos resolver este problema de forma definitiva mediante los siguientes pasos:

1. Detener y deshabilitar el servicio AnyDesk:

```bash
sudo systemctl stop anydesk
sudo systemctl disable anydesk
```

2. Configurar AnyDesk para se ejecute automáticamente al iniciar sesión, sólo para nuestro usuario, generando así un ID nuevo:

```bash
mkdir ~/.config/autostart
cp /etc/share/applicaciones.anydesk.desktop ~/.config/autostart
```

> El paso anterior copia el acceso directo de AnyDesk a la carpeta autostart de nuestro perfil, de modo que el programa vinculado a dicho acceso se abrirá automáticamente al iniciar sesión.

3. Cerrar la sesión y volver a iniciarla.






























