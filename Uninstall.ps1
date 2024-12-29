# Caminho do registro
$regPathSpotlight = "HKLM:\\SOFTWARE\\Policies\\Microsoft\\Windows\\CloudContent"

# Remover chaves do Spotlight
Remove-ItemProperty -Path $regPathSpotlight -Name "DisableWindowsSpotlightFeatures" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $regPathSpotlight -Name "DisableWindowsConsumerFeatures" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $regPathSpotlight -Name "DisableWindowsSpotlightOnLockScreen" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $regPathSpotlight -Name "DisableWindowsSpotlightOnActionCenter" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $regPathSpotlight -Name "DisableWindowsSpotlightSuggestions" -ErrorAction SilentlyContinue

Write-Output "Windows Spotlight reativado."
