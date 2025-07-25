$ConfigPath = "C:\ProgramData\Docker\config\daemon.json"
$ExpectedDataRoot = "D:\\Fadaka\\docker-data"
$NeedsRestart = $false

if (Test-Path $ConfigPath) {
    $daemonConfig = Get-Content $ConfigPath | ConvertFrom-Json

    if ($daemonConfig.'data-root' -ne $ExpectedDataRoot) {
        Write-Host "⚠️ Updating data-root path for Fadaka..."
        $daemonConfig.'data-root' = $ExpectedDataRoot
        $NeedsRestart = $true
    }

    if (-not $daemonConfig.'experimental') {
        Write-Host "⚠️ Enabling experimental features..."
        $daemonConfig.'experimental' = $true
        $NeedsRestart = $true
    }

    $daemonConfig | ConvertTo-Json -Depth 3 | Set-Content $ConfigPath
} else {
    Write-Host "📁 Creating daemon.json for Fadaka..."
    $config = @{
        "data-root" = $ExpectedDataRoot
        "experimental" = $true
        "debug" = $true
        "insecure-registries" = @("localhost:5000")
        "registry-mirrors" = @("https://mirror.gcr.io")
        "log-driver" = "json-file"
        "log-opts" = @{
            "max-size" = "100m"
            "max-file" = "3"
        }
    }

    $config | ConvertTo-Json -Depth 3 | Set-Content $ConfigPath
    $NeedsRestart = $true
}

if ($NeedsRestart) {
    Write-Host "🔄 Restarting Docker service..."
    Restart-Service docker
} else {
    Write-Host "✅ Docker daemon.json is already configured for Fadaka."
}
