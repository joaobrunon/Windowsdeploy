# Definindo o caminho para a pasta Proatec e o arquivo de log
$proatecPath = "$env:LOCALAPPDATA\proatec"
$logFile = "$proatecPath\log_veyon.txt"

# Função para gravar logs
function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message
    )

    Add-content $logFile -value "$(Get-Date) - $Message"
}

# 1) Verifique se o chocolatey se está instalado
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    # 2) Caso não esteja, instale o chocolatey
    Write-Log "Instalando Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Log "Chocolatey instalado."
} else {
    Write-Log "Chocolatey já está instalado."
}

# 3) Desinstale o Veyon (mantém as configurações)
Write-Log "Desinstalando Veyon, se estiver instalado..."
choco uninstall veyon -y --skip-autouninstaller

# 4) Instale o Veyon usando o Chocolatey
Write-Log "Instalando Veyon..."
choco install veyon -y

# 5, 6 e 7) Baixar os arquivos necessários e salvar na pasta proatec
$files = @(
    @{Name="leovegildo_public_key.pem"; Url="https://drive.google.com/uc?export=download&id=17ZOPb1DYA4ihWRCLGw3JDpt7iV0J25Ch"},
    @{Name="leovegildo_private_key.pem"; Url="https://drive.google.com/uc?export=download&id=18MQUoXceqngk9o94MWSbzflShifw2Q0r"},
    @{Name="configuracao.json"; Url="https://drive.google.com/uc?export=download&id=1QJF4T75AaS4gixxMQ30egpgE2xLFvXfr"}
)

foreach ($file in $files) {
    Write-Log "Baixando arquivo $($file.Name)..."
    Invoke-WebRequest -Uri $file.Url -OutFile "$proatecPath\$($file.Name)"
    Write-Log "Arquivo $($file.Name) baixado com sucesso."
}

# 8) Usando o Veyon CLI, importe a configuração do arquivo "configuracao.json"
# Nota: Este passo depende da localização exata e da sintaxe do comando Veyon CLI.
Write-Log "Importando a configuração usando Veyon CLI..."
& 'veyon-cli' config import "$proatecPath\configuracao.json"
Write-Log "Configuração importada com sucesso."

Write-Log "Script concluído."
