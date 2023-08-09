# Caminhos para as pastas Área de trabalho, Documentos, Imagens e Downloads
$desktopPath = [Environment]::GetFolderPath("Desktop")
$documentsPath = [Environment]::GetFolderPath("MyDocuments")
$picturesPath = [Environment]::GetFolderPath("MyPictures")
$downloadsPath = [Environment]::GetFolderPath("MyDocuments") + "\Downloads"

# Remove todos os arquivos e subpastas da Área de trabalho, Documentos, Imagens e Downloads
Get-ChildItem -Path $desktopPath -Recurse | Remove-Item -Force -Recurse
Get-ChildItem -Path $documentsPath -Recurse | Remove-Item -Force -Recurse
Get-ChildItem -Path $picturesPath -Recurse | Remove-Item -Force -Recurse
Get-ChildItem -Path $downloadsPath -Recurse | Remove-Item -Force -Recurse

# Cria atalhos para os navegadores no modo privado na Área de trabalho

# Google Chrome
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$desktopPath\Google Chrome - Incognito.lnk")
$Shortcut.TargetPath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$Shortcut.Arguments = "-incognito"
$Shortcut.Save()

# Mozilla Firefox
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$desktopPath\Mozilla Firefox - Private.lnk")
$Shortcut.TargetPath = "C:\Program Files\Mozilla Firefox\firefox.exe"
$Shortcut.Arguments = "-private"
$Shortcut.Save()

# Microsoft Edge
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$desktopPath\Microsoft Edge - InPrivate.lnk")
$Shortcut.TargetPath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$Shortcut.Arguments = "-inprivate"
$Shortcut.Save()
