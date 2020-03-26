Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "CombineUtility"
s.summary = "CombineUtility provides additional support to Combine and CombineRx."
s.requires_arc = true
s.version = "0.5.5"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com",
"Leon Nguyen" => "leon.nguyen291@gmail.com" }
s.homepage = "https://github.com/adamaszhu/CombineUtility"
s.source = { :git => "https://github.com/adamaszhu/CombineUtility.git",
:tag => "#{s.version}" }
s.source_files = "CombineUtility/**/*.{swift}"
s.swift_version = "4.2"

s.framework = "Foundation"
s.dependency 'CombineRx', '~> 1.0.0'

end
