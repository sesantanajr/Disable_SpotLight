# Disable_SpotLight

Configurar os Comandos:

Comando de Instalação:
powershell.exe -ExecutionPolicy Bypass -File Install.ps1

Comando de Desinstalação:
powershell.exe -ExecutionPolicy Bypass -File Uninstall.ps1

Detecção: Configure a detecção para verificar se as chaves de registro foram aplicadas:
    Tipo: Registro.
    Caminho: HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent.
    Nome: DisableWindowsSpotlightFeatures.
