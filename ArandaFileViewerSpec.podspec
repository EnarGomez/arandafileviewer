Pod::Spec.new do |s|

#Configuracion
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "ArandaFileViewer"
s.summary = "ArandaFileViewer es una librería para visualizacion de archivos usando AVFoundation."
s.requires_arc = true

#Version
s.version = "0.0.1"

#Licencia
s.license = { :type => "MIT", :file => "LICENSE" }

# Autor
s.author = { "Enar Gómez" => "enar.gomez@arandasoft.com" }

# pagina inicial
s.homepage = "https://github.com/EnarGomez/arandafileviewer"

# repositorio
s.source = { :git => "https://github.com/EnarGomez/arandafileviewer.git",
             :tag => "#{s.version}" }

# dependencias
#s.framework = "UIKit"

# archivos de software
s.source_files = "ArandaFileViewer/**/*.{h,m,swift}"
s.exclude_files = "ArandaFileViewer/*.plist"
# archivos de recursos
s.resources = "ArandaFileViewer/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# swift version
s.swift_version = "5.0"

end
