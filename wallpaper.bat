REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallpaper /t REG_DWORD /d 1 /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v NoDispBackgroundPage /t REG_DWORD /d 1 /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v NoDispAppearancePage /t REG_DWORD /d 1 /f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v Wallpaper /t REG_SZ /d "C:\Windows\Web\Wallpaper\Windows\img0.jpg" /f
gpupdate /force