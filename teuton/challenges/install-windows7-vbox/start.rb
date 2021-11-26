
group "Install Windows 7 on a VBox virtual machine" do

  target "Set 2GB of RAM memory for the virtual machine"
  goto :host1, :exec => "wmic ComputerSystem get TotalPhysicalMemory"
  expect "2147016704"

  target "Set a 20GB hard disk drive for the virtual machine"
  goto :host1, :exec => 'wmic diskdrive get name,size | findstr /c:"PHYSICALDRIVE0"'
  expect "21467980800"

  target "Install Windows 7 Enterprise on the virtual machine"
  goto :host1, :exec => 'systeminfo | findstr /C:"Nombre del sistema operativo"'
  expect "Microsoft Windows 7 Enterprise"

  target "Create user Alumno and make him member of Administradores local group"
  goto :host1, :exec => "net localgroup Administradores"
  expect "Alumno"

  #target "Activate Windows 7"
  #goto :host1, :exec => 'cscript /Nologo "%windir%\System32\slmgr.vbs" /dlv | findstr /c:"Estado de la licencia"'
  #expect "con licencia"

  target "Set IDP as computer name"
  goto :host1, :exec => "hostname"
  expect "IDP"

  target "Set TimeZone to UTC+00:00 (Dublin, Edimburgh, Lisbon, London)"
  goto :host1, :exec => "tzutil /g"
  expect "GMT Standard Time"

  target "Install Guest Additions on the virtual machine"
  goto :host1, :exec => 'reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall'
  expect "Oracle VM VirtualBox Guest Additions"
  
end

play do
  show
  export :format => :html
  send :copy_to => :host1, :remote_dir => "."
end
