```
Challenge name : .
Date           : 2019-09-21 14:54:26 +0100
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

## Install Ubuntu 18.04.1 LTS on a VBox virtual machine


Go to [HOST1](#required-hosts) host, and do next:

* Set 4GB of RAM memory for the virtual machine
* Set a 20GB hard disk drive for the virtual machine
* Install Ubuntu 18.04.1 LTS on the virtual machine
* Create user Alumno and make him member of sudo group
* Set IDP as computer name
* Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London)
* Install Guest Additions on the virtual machine
