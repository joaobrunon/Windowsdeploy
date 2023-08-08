# Instala o Windows Package Manager (winget)
Write-Output "Baixando e instalando o Windows Package Manager..."
$wingetInstallerUrl = "https://github.com/microsoft/winget-cli/releases/download/v1.1.12653/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
Invoke-WebRequest -Uri $wingetInstallerUrl -OutFile "$env:TEMP\winget.msixbundle"
Add-AppPackage -Path "$env:TEMP\winget.msixbundle"
Write-Output "Windows Package Manager instalado."

# Verifica se o Chocolatey já está instalado
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    # Instala o Chocolatey
    Write-Output "Instalando o Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Output "Chocolatey instalado."
} else {
    Write-Output "O Chocolatey já está instalado."
}

# Cria a pasta proatec em AppData\Local
Write-Output "Criando pasta proatec..."
$folderPath = New-Item -Path "$env:LOCALAPPDATA\" -Name "proatec" -ItemType "directory"
Write-Output "Pasta proatec criada em: $($folderPath.FullName)"

# Baixa o arquivo para a pasta proatec
Write-Output "Baixando arquivo wallpaper.bat..."
$downloadPath = Join-Path -Path $folderPath.FullName -ChildPath "wallpaper.bat"
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/joaobrunon/Windowsdeploy/main/wallpaper.bat' -OutFile $downloadPath
Write-Output "Arquivo wallpaper.bat baixado para: $downloadPath"

# Executa o arquivo wallpaper.bat
Write-Output "Executando arquivo wallpaper.bat..."
$process = Start-Process -FilePath $downloadPath -PassThru
Write-Output "Arquivo wallpaper.bat executado. ID do processo: $($process.Id)"

# Define o plano de fundo da área de trabalho como a imagem padrão do Windows
Write-Output "Definindo plano de fundo da área de trabalho..."
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
Write-Output "Plano de fundo da área de trabalho definido para: $wallpaperPath"
