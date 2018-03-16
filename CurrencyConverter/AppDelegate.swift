//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Anton Nazarov1 on 3/15/18.
//  Copyright © 2018 Electrolux. All rights reserved.
//

import UIKit
import Then
import Swinject
import SwinjectAutoregistration
import SwiftyBeaver

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  private let assembly = Assembler(MainAssembler.getAssemblies())
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    configLogger()
    window = createWindow()
    return true
  }

  func createWindow() -> UIWindow {
    return UIWindow(frame: UIScreen.main.bounds).then {
      $0.backgroundColor = UIColor.white
      $0.makeKeyAndVisible()
      $0.rootViewController = assembly.resolver ~> ConverterViewController.self
    }
  }

  func configLogger() {
    log.addDestination(ConsoleDestination())
  }
}

