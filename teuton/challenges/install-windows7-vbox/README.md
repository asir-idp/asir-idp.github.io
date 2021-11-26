```
Test unit name : install-windows7-vbox
Date           : 2021-11-26 12:55:10 +0000
Teuton version : 2.2.0
```

# install-windows7-vbox

### Required hosts

| ID | Host | Configuration |
| --- | --- | --- |
| 1 | HOST1 |  |

> NOTE: SSH Service installation is required on every host.

### Required params
* host1_ip
* host1_password
* host1_username

> NOTE: Save every ':param: value' into config file.

## Install windows 7 on a vbox virtual machine


Go to [HOST1](#required-hosts) host, and do next:
* Set 2GB of RAM memory for the virtual machine.
* Set a 20GB hard disk drive for the virtual machine.
* Install Windows 7 Enterprise on the virtual machine.
* Create user Alumno and make him member of Administradores local group.
* Set IDP as computer name.
* Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London).
* Install Guest Additions on the virtual machine.
