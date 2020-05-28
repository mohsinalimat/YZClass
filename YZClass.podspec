Pod::Spec.new do |s|
  s.name                    = 'YZClass'
  s.version                 = '0.1.0'
  s.summary                 = 'YZLibraries is design and developed for Yudiz Solutions Pvt. Ltd.'
  s.description             = <<-DESC
  "YZLibraries is useful for Junior iOS developer and trainee, so it easy can be easy to develop application and reduce code lines."
                       DESC
  s.homepage                = 'https://github.com/yudiz-vipul/YZClass'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { 'yudiz-vipul' => 'vipul.p@yudiz.in' }
  s.source                  = { :git => 'https://github.com/yudiz-vipul/YZClass.git', :tag => s.version.to_s }
  s.swift_version           = '5.0'
  s.ios.deployment_target   = '12.0'
  s.source_files            = 'Extension/**/*.swift', 'Common/**/*.swift'
  s.dependency 'PhoneNumberKit'
end
