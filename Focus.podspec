Pod::Spec.new do |s|
  s.name        = "Focus"
  s.version     = "0.4.0"
  s.summary     = "Focus is an Optics library for Swift (where Optics includes Lens, Prisms, and Isos) that is inspired by Haskell's Lens library."
  s.homepage    = "https://github.com/typelift/Focus"
  s.license     = { :type => "MIT" }
  s.authors     = { "CodaFi" => "devteam.codafi@gmail.com", "pthariensflame" => "alexanderaltman@me.com" }

  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.1"
  s.watchos.deployment_target = "2.1"  
  s.source   = { :git => "https://github.com/typelift/Focus.git", :tag => "#{s.version}", :submodules => true }
  s.source_files = "Sources/Focus/*.swift", "Hack/*.swift"
end