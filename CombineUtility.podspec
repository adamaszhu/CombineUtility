Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '13.0'
s.name = "CombineUtility"
s.summary = "CombineUtility provides additional support to Combine and CombineRx."
s.requires_arc = true
s.version = "1.0.2"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com" }
s.homepage = "https://github.com/adamaszhu/CombineUtility"
s.source = { :git => "https://github.com/adamaszhu/CombineUtility.git",
             :tag => "#{s.version}" }
s.frameworks = "Combine", "Foundation"
s.source_files = "CombineUtility/**/*.{swift}"
s.swift_version = "5"

end
