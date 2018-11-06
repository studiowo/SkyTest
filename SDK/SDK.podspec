Pod::Spec.new do |s|

  s.name          = "SDK"
  s.version       = "0.0.1"
  s.summary       = "SDK Framework"
  s.homepage      = "http://www.renatomatos.com.br"
  s.license       = "Renato Matos"
  s.author        = { "Renato Matos" => "renatorsarro@gmail.com" }
  s.platform      = :ios
  s.source        = { :path => '.' }
  s.source_files  = "SDK", "SDK/**/*.{h,m,swift}"
  s.resource_bundles = {}
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
  s.ios.deployment_target = '9.0'
  s.ios.vendored_frameworks = 'Products/SDK.framework'
  s.dependency 'Alamofire'
  s.dependency 'AlamofireImage'
  s.dependency 'AlamofireNetworkActivityLogger'
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Database'
  s.dependency 'Firebase/RemoteConfig'
  s.dependency 'Hero'
  s.dependency 'SwiftyRSA'

end
