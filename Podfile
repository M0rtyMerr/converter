platform :ios, '11.0'

target 'CurrencyConverter' do
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'Then'
  pod 'SwiftLint'

  target 'CurrencyConverterTests' do
    inherit! :search_paths
    pod 'RxBlocking', '~> 4.0'
    pod 'RxTest',     '~> 4.0'
  end

  target 'CurrencyConverterUITests' do
    inherit! :search_paths
  end
end
