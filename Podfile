platform :ios, '11.0'

target 'CurrencyConverter' do
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'Then'
  pod 'SwiftLint'
  pod 'RxAlamofire'
  pod 'Swinject'
  pod 'SwinjectAutoregistration'
  pod 'RxSwiftExt'
  pod 'SwiftyBeaver'

  def testing_pods
      pod 'Quick'
      pod 'Nimble'
      pod 'Fakery'
      pod 'OHHTTPStubs/Swift'
      pod 'RxNimble'
  end

  target 'CurrencyConverterTests' do
    inherit! :search_paths
    testing_pods
    pod 'RxBlocking'
  end

  target 'CurrencyConverterUITests' do
    inherit! :search_paths
    testing_pods
  end
end
