# Define o caminho para o arquivo de log
$logPath = Join-Path -Path $PSScriptRoot -ChildPath "wallpaper_log.txt"

function Write-LogOutput {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Write-Output $Message | Out-File -Append -FilePath $logPath
}

# Instala o Windows Package Manager (winget)
Write-LogOutput "Baixando e instalando o Windows Package Manager..."
$wingetInstallerUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri $wingetInstallerUrl -OutFile "$env:TEMP\winget.msixbundle"
Add-AppPackage -Path "$env:TEMP\winget.msixbundle"
Write-LogOutput "Windows Package Manager instalado."

# Verifica se o Chocolatey já está instalado
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    # Instala o Chocolatey
    Write-LogOutput "Instalando o Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-LogOutput "Chocolatey instalado."
} else {
    Write-LogOutput "O Chocolatey já está instalado."
}

# Cria a pasta proatec em AppData\Local
Write-LogOutput "Criando pasta proatec..."
$folderPath = New-Item -Path "$env:LOCALAPPDATA\" -Name "proatec" -ItemType "directory"
Write-LogOutput "Pasta proatec criada em: $($folderPath.FullName)"

# Baixa o arquivo para a pasta proatec
Write-LogOutput "Baixando arquivo wallpaper.bat..."
$downloadPath = Join-Path -Path $folderPath.FullName -ChildPath "wallpaper.bat"
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/joaobrunon/Windowsdeploy/main/wallpaper.bat' -OutFile $downloadPath
Write-LogOutput "Arquivo wallpaper.bat baixado para: $downloadPath"

# Executa o arquivo wallpaper.bat
Write-LogOutput "Executando arquivo wallpaper.bat..."
$process = Start-Process -FilePath $downloadPath -PassThru
Write-LogOutput "Arquivo wallpaper.bat executado. ID do processo: $($process.Id)"

# Define o plano de fundo da área de trabalho como a imagem padrão do Windows
Write-LogOutput "Definindo plano de fundo da área de trabalho..."
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

$wallpaperPath = "C:\Windows\Web\Wallpaper\Windows\img0.jpg"
[Wallpaper]::SystemParametersInfo(20, 0, $wallpaperPath, 3)
Write-LogOutput "Plano de fundo da área de trabalho definido para: $wallpaperPath"
