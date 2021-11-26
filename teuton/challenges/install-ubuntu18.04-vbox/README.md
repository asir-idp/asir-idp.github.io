```
Test unit name : install-ubuntu18.04-vbox
Date           : 2021-11-26 12:54:54 +0000
Teuton version : 2.2.0
```

# install-ubuntu18.04-vbox

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

## Install ubuntu 18.04.1 lts on a vbox virtual machine


Go to [HOST1](#required-hosts) host, and do next:
* Set 4GB of RAM memory for the virtual machine.
* Set a 20GB hard disk drive for the virtual machine.
* Install Ubuntu 18.04.1 LTS on the virtual machine.
* Create user Alumno and make him member of sudo group.
* Set IDP as computer name.
* Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London).
* Install Guest Additions on the virtual machine.
