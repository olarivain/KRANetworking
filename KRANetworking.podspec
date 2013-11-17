Pod::Spec.new do |s|
  s.name         = "KRANetworking"
  s.version      = "0.1.0"
  s.summary      = "iOS HTTP library."
  s.description  = <<-DESC
                    A simple HTTP library.
                   DESC
  s.homepage     = "https://github.com/olarivain/KRANetworking"

  s.license      = 'MIT'
  s.author       = { "Kra Larivain" => "olarivain@gmail.com" }
  s.source       = { :git => "https://github.com/olarivain/KRANetworking.git", :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = true

  s.source_files  = ["Classes/**/*.{h,m,c,mm,cpp}"]
  s.resources = 'Assets'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  # s.dependency 'JSONKit', '~> 1.4'
end
