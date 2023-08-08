# Cria a pasta proatec em AppData\Local
New-Item -Path "$env:APPDATA\Local" -Name "proatec" -ItemType "directory"

# Baixa o arquivo para a pasta proatec
Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/joaobrunon/Windowsdeploy/main/wallpaper.bat?token=GHSAT0AAAAAACF3B3A6GD4TBDD2AB5UNSCOZGRVNDA' -OutFile "$env:APPDATA\Local\proatec\wallpaper.bat"

# Executa o arquivo wallpaper.bat
Start-Process -FilePath "$env:APPDATA\Local\proatec\wallpaper.bat"

# Define o plano de fundo da área de trabalho como a imagem padrão do Windows
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

# Cria um atalho para a pasta proatec na área de trabalho
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\proatec.lnk")
$Shortcut.TargetPath = "$env:APPDATA\Local\proatec"
$Shortcut.Save()
