
group "Install Ubuntu 18.04.1 LTS on a VBox virtual machine" do

  debug = false

  target "Set 4GB of RAM memory for the virtual machine"
  goto :host1, :exec => 'LC_ALL=POSIX free --giga -h | grep "^Mem" | awk \'{print $2}\''
  result.debug if debug
  expect "4.0G"

  target "Set a 20GB hard disk drive for the virtual machine"
  goto :host1, :exec => "cat /sys/block/sda/size"
  result.debug if debug
  expect "41943040"

  target "Install Ubuntu 18.04.1 LTS on the virtual machine"
  goto :host1, :exec => "cat /etc/issue"
  result.debug if debug
  expect "Ubuntu 18.04"

  target "Create user Alumno and make him member of sudo group"
  goto :host1, :exec => "id alumno"
  result.debug if debug
  expect "(sudo)"

  target "Set IDP as computer name"
  goto :host1, :exec => "hostname"
  result.debug if debug
  expect /^IDP$/

  target "Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London)"
  goto :host1, :exec => "timedatectl"
  result.debug if debug
  expect "Time zone: Atlantic/Canary"

  target "Install Guest Additions on the virtual machine"
  goto :host1, :exec => "lsmod"
  result.debug if debug
  expect "vboxguest"
  
end

play do
  show
  export :format => :json
  export
  send :copy_to => :host1, :remote_dir => "."
end
