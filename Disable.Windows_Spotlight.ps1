try {
    # Caminho do registro para desativar o Windows Spotlight
    $regPathSpotlight = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"

    # Força a criação da chave principal CloudContent
    if (-not (Test-Path $regPathSpotlight)) {
        New-Item -Path $regPathSpotlight -Force | Out-Null
        Write-Output "Chave criada: $regPathSpotlight"
    } else {
        Write-Output "Chave já existente: $regPathSpotlight"
    }

    # Criação ou substituição de todas as chaves relacionadas ao Spotlight
    $keysSpotlight = @(
        @{ Name = "DisableWindowsSpotlightFeatures"; Value = 1; Type = "DWord" },
        @{ Name = "DisableWindowsConsumerFeatures"; Value = 1; Type = "DWord" },
        @{ Name = "DisableWindowsSpotlightOnLockScreen"; Value = 1; Type = "DWord" },
        @{ Name = "DisableWindowsSpotlightOnActionCenter"; Value = 1; Type = "DWord" },
        @{ Name = "DisableWindowsSpotlightSuggestions"; Value = 1; Type = "DWord" }
    )

    foreach ($key in $keysSpotlight) {
        try {
            New-ItemProperty -Path $regPathSpotlight -Name $key.Name -Value $key.Value -PropertyType $key.Type -Force | Out-Null
            Write-Output "Chave configurada: $key.Name com valor $key.Value"
        } catch {
            Write-Output "Erro ao configurar chave: $key.Name - $_"
        }
    }

    # Proteção das chaves contra exclusão ou modificação
    try {
        $aclSpotlight = Get-Acl $regPathSpotlight
        $aclSpotlight.SetAccessRuleProtection($true, $false)  # Protege o registro

        $denyRuleSpotlight = New-Object System.Security.AccessControl.RegistryAccessRule (
            "Everyone",
            "Delete, WriteKey",
            "Deny"
        )

        $aclSpotlight.AddAccessRule($denyRuleSpotlight)
        Set-Acl -Path $regPathSpotlight -AclObject $aclSpotlight
        Write-Output "Proteção aplicada ao Spotlight"
    } catch {
        Write-Output "Erro ao proteger Spotlight: $_"
    }

    Write-Output "Windows Spotlight desativado permanentemente com proteção."
} catch {
    Write-Output "Erro ao configurar chaves de registro: $_"
    Exit 1
}
