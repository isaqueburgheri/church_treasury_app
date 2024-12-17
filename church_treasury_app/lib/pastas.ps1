# Diretório base
$baseDir = "."

# Criar diretórios
New-Item -ItemType Directory -Path "$baseDir/pages/admin" -Force
New-Item -ItemType Directory -Path "$baseDir/pages/user" -Force
New-Item -ItemType Directory -Path "$baseDir/models" -Force
New-Item -ItemType Directory -Path "$baseDir/services" -Force

# Criar arquivos
New-Item -ItemType File -Path "$baseDir/main.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/admin/admin_home.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/admin/cadastro_tesoureiros.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/admin/listagem_igrejas.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/admin/detalhes_igreja.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/admin/relatorios.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/user/user_home.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/user/envio_comprovantes.dart" -Force
New-Item -ItemType File -Path "$baseDir/pages/login.dart" -Force
New-Item -ItemType File -Path "$baseDir/models/user.dart" -Force
New-Item -ItemType File -Path "$baseDir/models/igreja.dart" -Force
New-Item -ItemType File -Path "$baseDir/models/comprovante.dart" -Force
New-Item -ItemType File -Path "$baseDir/services/api_service.dart" -Force
New-Item -ItemType File -Path "$baseDir/services/auth_service.dart" -Force

# Mensagem final
Write-Host "Estrutura criada com sucesso!" -ForegroundColor Green
