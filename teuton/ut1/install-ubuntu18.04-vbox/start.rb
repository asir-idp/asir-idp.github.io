
group "Install Ubuntu 18.04.1 LTS on a VBox virtual machine" do

  debug = false

  target "Set 4GB of RAM memory for the virtual machine"
  goto :host1, :exec => 'cat /proc/meminfo | grep MemTotal | tr -s " " | cut -d" " -f2'
  puts result.debug if debug
  expect result.near? 4039732

  target "Set a 20GB hard disk drive for the virtual machine"
  goto :host1, :exec => "cat /sys/block/sda/size"
  puts result.debug if debug
  expect "41943040"

  target "Install Ubuntu 18.04.1 LTS on the virtual machine"
  goto :host1, :exec => "cat /etc/issue"
  puts result.debug if debug
  expect "Ubuntu 18.04"

  target "Create user Alumno and make him member of sudo group"
  goto :host1, :exec => "id alumno"
  puts result.debug if debug
  expect "(sudo)"

  target "Set IDP as computer name"
  goto :host1, :exec => "hostname"
  puts result.debug if debug
  expect /^IDP$/

  target "Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London)"
  goto :host1, :exec => "timedatectl"
  puts result.debug if debug
  expect "Time zone: Atlantic/Canary"

  target "Install Guest Additions on the virtual machine"
  goto :host1, :exec => "lsmod"
  puts result.debug if debug
  expect "vboxguest"
  
end

play do
  show
  export
end
