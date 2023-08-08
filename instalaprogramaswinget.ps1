# Define a lista de pacotes a serem instalados
$packages = "7zip", "Google.Chrome", "Mozilla.Firefox", "PDF24.PDFCreator", "VeyonTechnologies.Veyon"

# Para cada pacote na lista...
foreach ($package in $packages) {
  # Tenta instalar o pacote
  try {
    # Se o pacote já estiver instalado, essa linha lançará uma exceção
    winget install $package --silent --accept-source-agreements
    Write-Host "O pacote $package foi instalado com sucesso."
  }
  # Captura a exceção se o pacote já estiver instalado
  catch {
    Write-Host "Não foi possível instalar o pacote $package. Ele pode já estar instalado."
  }
}
