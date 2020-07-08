
Pod::Spec.new do |s|
  s.name         = "RNHttpServer"
  s.version      = "0.0.1"
  s.summary      = "RNHttpServer"
  s.description  = <<-DESC
                    A simple HTTP server for react native
                   DESC
  s.homepage     = "https://github.com/nmartinezb3/react-native-http-server"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = { "author" => "hi@nmartinez.dev" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/nmartinezb3/react-native-http-server.git", :tag => "master" }
  s.source_files  = "ios/**/*.{h,m,swift}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"
  s.dependency "GCDWebServer", "~> 3.5.3"
end

