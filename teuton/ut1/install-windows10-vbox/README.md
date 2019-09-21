```
Challenge name : .
Date           : 2019-09-21 14:54:31 +0100
Teuton version : 2.1.0
```
# README.md

### Required hosts

| ID | Host | Configuration |
| -- | ---- | ------------- |
|1|HOST1||

> NOTE: SSH Service installation is required on every host.

### Required params
* host1_ip
* host1_password
* host1_username

> NOTE:
> * Teuton software must known this information.
> * Save them into challenge config file.

## Install Windows 10 on a VBox virtual machine


Go to [HOST1](#required-hosts) host, and do next:

* Set 4GB of RAM memory for the virtual machine
* Set a 25GB hard disk drive for the virtual machine
* Install Windows 10 Pro on the virtual machine
* Create user Alumno and make him member of Administradores local group
* Activate Windows 10
* Set IDP as computer name
* Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London)
* Install Guest Additions on the virtual machine
