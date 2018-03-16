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

class ConverterViewController: UIViewController {
  private var isPickingFrom = true
  private let disposeBag = DisposeBag()
  @IBOutlet private var currencyPicker: UIPickerView!
  @IBOutlet var fromCurrencyName: UIButton!
  @IBOutlet var toCurrencyName: UIButton!
  @IBOutlet private var toCurrencyAmount: UITextField!
  @IBOutlet private var fromCurrencyAmount: UITextField!

  var presenter: ConverterPresenter!

  override func viewDidLoad() {
    super.viewDidLoad()
    subscribePresenter()
    setDefaultState()
    subscribeActions()
    configurePicker()
  }
}

private extension ConverterViewController {
  func subscribePresenter() {
    presenter.toAmount.bind(to: toCurrencyAmount.rx.text).disposed(by: disposeBag)
    presenter.fromAmount.bind(to: fromCurrencyAmount.rx.text).disposed(by: disposeBag)
  }

  func subscribeActions() {
    fromCurrencyAmount.rx.text.orEmpty.asObservable().apply(inputPolicy)
      .map { [unowned self] in
        ConverterAction.changeState(from: self.fromCurrencyName.titleLabel?.text ?? "",
                                    to: self.toCurrencyName.titleLabel?.text ?? "",
                                    amount: $0,
                                    changedBy: .from) }
      .subscribe(onNext: { [unowned self] in
        self.presenter.dispatch(action: $0)
      }).disposed(by: disposeBag)

    toCurrencyAmount.rx.text.orEmpty.asObservable().apply(inputPolicy)
      .map { [unowned self] in
        ConverterAction.changeState(from: self.fromCurrencyName.titleLabel?.text ?? "",
                                    to: self.toCurrencyName.titleLabel?.text ?? "",
                                    amount: $0,
                                    changedBy: .to) }
      .subscribe(onNext: { [unowned self] in
        self.presenter.dispatch(action: $0)
      }).disposed(by: disposeBag)
  }

  func inputPolicy(_ input: Observable<String>) -> Observable<String> {
    return input
      .throttle(0.3, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
  }

  func configurePicker() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPickerView))
    view.addGestureRecognizer(tapGesture)
    currencyPicker.isHidden = true
    fromCurrencyName.rx.tap.subscribe(onNext: {
      self.isPickingFrom = true
      self.currencyPicker.isHidden = false
      //      self.currencyPicker.selectItem
    }).disposed(by: disposeBag)

    toCurrencyName.rx.tap.subscribe(onNext: {
      self.isPickingFrom = false
      self.currencyPicker.isHidden = false
    }).disposed(by: disposeBag)

    presenter.currencies.bind(to: currencyPicker.rx.itemTitles) { _, item in
      return item
      }.disposed(by: disposeBag)

    currencyPicker.rx.modelSelected(String.self)
      .map { $0[0] }
      .subscribe(onNext: {
        (self.isPickingFrom ? self.fromCurrencyName : self.toCurrencyName).setTitle($0, for: .normal)
      }).disposed(by: disposeBag)
  }

  @objc func dismissPickerView() {
    currencyPicker.isHidden = true
  }
}

// MARK: - Default state
private extension ConverterViewController {
  func setDefaultState() {
    fromCurrencyName.setTitle(DefaultCurrency.from, for: .normal)
    toCurrencyName.setTitle(DefaultCurrency.to, for: .normal)
    fromCurrencyAmount.text = DefaultCurrency.amount

    presenter.dispatch(action: .changeState(from: DefaultCurrency.from,
                                            to: DefaultCurrency.to,
                                            amount: DefaultCurrency.amount,
                                            changedBy: .from))
  }
}

