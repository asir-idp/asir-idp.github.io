
group "Install Windows 10 on a VBox virtual machine" do

  debug = false

  target "Set 4GB of RAM memory for the virtual machine"
  goto :host1, :exec => "powershell -command (Get-WmiObject -Class Win32_ComputerSystem).TotalPhysicalMemory -eq 4294496256"
  puts result.debug if debug
  expect "True"

  target "Set a 25GB hard disk drive for the virtual machine"
  goto :host1, :exec => "powershell -command (get-disk -Number 0).Size/1gb -eq 25"
  puts result.debug if debug
  expect "True"

  target "Install Windows 10 Pro on the virtual machine"
  goto :host1, :exec => "powershell -command (Get-CimInstance Win32_Operatingsystem).Caption"
  puts result.debug if debug
  expect "Microsoft Windows 10 Pro"

  target "Create user Alumno and make him member of Administradores local group"
  goto :host1, :exec => "powershell -command (Get-LocalGroupMember Administradores).Name"
  puts result.debug if debug
  expect "IDP\\Alumno"

  target "Activate Windows 10"
  goto :host1, :exec => 'cscript /Nologo "%windir%\System32\slmgr.vbs" /dlv'
  puts result.debug if debug
  expect "Estado de la licencia: con licencia"

  target "Set IDP as computer name"
  goto :host1, :exec => "powershell -command $env:ComputerName"
  puts result.debug if debug
  expect "IDP"

  target "Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London)"
  goto :host1, :exec => "powershell -command (Get-TimeZone).Id"
  puts result.debug if debug
  expect "GMT Standard Time"

  target "Install Guest Additions on the virtual machine"
  goto :host1, :exec => "powershell -command (Get-ItemProperty HKLM:\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\*).DisplayName"
  puts result.debug if debug
  expect "Oracle VM VirtualBox Guest Additions"
  
end

play do
  show
  export :format => :json
  export
  send :copy_to => :host1, :remote_dir => "."
end
