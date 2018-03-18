//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov1 on 3/15/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxSwiftExt

final class ConverterViewController: UIViewController {
  @IBOutlet private var currencyPicker: UIPickerView!
  @IBOutlet private var fromCurrencyName: UITextField!
  @IBOutlet private var toCurrencyName: UITextField!
  @IBOutlet private var toCurrencyAmount: UITextField!
  @IBOutlet private var fromCurrencyAmount: UITextField!
  private let viewPickerTapRecognizer = UITapGestureRecognizer()
  private let disposeBag = DisposeBag()
  private var isPickingFrom = true
  var presenter: ConverterPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()
    addGestureRecognizers()
    setDefaultState()
    subscribePresenter()
    configurePicker()
    toCurrencyName.delegate = self
    fromCurrencyName.delegate = self
    toCurrencyAmount.delegate = self
  }
}

// MARK: - GestureRecognizer
private extension ConverterViewController {
  func addGestureRecognizers() {
    view.addGestureRecognizer(viewPickerTapRecognizer)
  }
}

// MARK: - Presenter
private extension ConverterViewController {
  func subscribePresenter() {
    presenter.subscribeState(
      fromCurrency: fromCurrencyName.rx.observe(String.self, #keyPath(UITextField.text)).unwrap().apply(inputPolicy),
      toCurrency: toCurrencyName.rx.observe(String.self, #keyPath(UITextField.text)).unwrap().apply(inputPolicy),
      amount: fromCurrencyAmount.rx.text.orEmpty.asObservable().apply(inputPolicy)
    )

    presenter.amount.bind(to: toCurrencyAmount.rx.text).disposed(by: disposeBag)

    presenter.error.map {
      UIAlertController(title: "Error", message: $0, preferredStyle: .alert).then {
        $0.addAction(UIAlertAction(title: "Ok", style: .default))
      }
    }.subscribe(onNext: {
      self.present($0, animated: true)
    }).disposed(by: disposeBag)
  }

  func inputPolicy(_ input: Observable<String>) -> Observable<String> {
    return input
      .debounce(0.3, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
  }
}

// MARK: - Picker
private extension ConverterViewController {
  func configurePicker() {
    currencyPicker.isHidden = true

    fromCurrencyName.rx.controlEvent(.touchDown).subscribe(onNext: { _ in
      self.isPickingFrom = true
      self.currencyPicker.isHidden = false
    }).disposed(by: disposeBag)

    toCurrencyName.rx.controlEvent(.touchDown).subscribe(onNext: {
      self.isPickingFrom = false
      self.currencyPicker.isHidden = false
    }).disposed(by: disposeBag)

    presenter.currencies.bind(to: currencyPicker.rx.itemTitles) { _, item in
      return item
    }.disposed(by: disposeBag)

    currencyPicker.rx.modelSelected(String.self)
      .map { $0[0] }
      .subscribe(onNext: { [unowned self] in
        (self.isPickingFrom ?  self.fromCurrencyName : self.toCurrencyName).text = $0
      }).disposed(by: disposeBag)

    viewPickerTapRecognizer.rx.event.subscribe(onNext: { [unowned self] _ in
      self.currencyPicker.isHidden = true
    }).disposed(by: disposeBag)
  }
}

// MARK: - Default state
private extension ConverterViewController {
  func setDefaultState() {
    fromCurrencyName.text = DefaultCurrency.from
    toCurrencyName.text = DefaultCurrency.to
    fromCurrencyAmount.text = DefaultCurrency.amount
  }
}

// MARK: - UITextFieldDelegate
extension ConverterViewController: UITextFieldDelegate {
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return false
  }
}
