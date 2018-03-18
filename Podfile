platform :ios, '11.0'

target 'CurrencyConverter' do
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxAlamofire'
  pod 'RxSwiftExt'
  pod 'Alamofire'
  pod 'Then'
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'SwiftyBeaver'

  def testing_pods
      pod 'Quick'
      pod 'Nimble'
      pod 'Fakery'
      pod 'RxNimble'
      pod 'RxBlocking'
  end

  target 'CurrencyConverterTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'CurrencyConverterUITests' do
    inherit! :search_paths
  end
end
