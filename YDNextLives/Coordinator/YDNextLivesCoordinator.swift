//
//  YDNextLivesCoordinator.swift
//  YDNextLives
//
//  Created by Douglas Hennrich on 24/03/21.
//

import UIKit

import YDB2WIntegration
import YDExtensions

public typealias YDNextLives = YDNextLivesCoordinator

public class YDNextLivesCoordinator {
  // MARK: Properties
  var rootViewController: UIViewController {
    return self.navigationController
  }

  lazy var navigationController: UINavigationController = {
    let nav = UINavigationController()
    nav.navigationBar.prefersLargeTitles = true

    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      let appearanceStandard = UINavigationBarAppearance()

      appearance.shadowImage = UIImage()
      appearance.backgroundImage = UIImage()
      appearance.titleTextAttributes = [.foregroundColor: UIColor.Zeplin.black]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.Zeplin.black]
      appearance.backgroundColor = .white
      appearance.shadowColor = nil

      appearanceStandard.titleTextAttributes = [.foregroundColor: UIColor.Zeplin.black]
      appearanceStandard.backgroundColor = .white
      appearanceStandard.shadowColor = UIColor.Zeplin.grayDisabled

      nav.navigationBar.compactAppearance = appearance
      nav.navigationBar.standardAppearance = appearanceStandard
      nav.navigationBar.scrollEdgeAppearance = appearance
    } else {
      nav.navigationBar.shadowImage = UIImage()
      nav.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.Zeplin.black]
      nav.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.Zeplin.black]
    }

    nav.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    nav.navigationBar.tintColor = UIColor.Zeplin.redBranding
    return nav
  }()

  // MARK: Init
  public init() {}

  // MARK: Start
  public func start() {
    let topViewController = UIApplication.shared.keyWindow?
      .rootViewController?.topMostViewController()

    let vc = HomeViewController()

    let viewModel = HomeViewModel(navigation: self)
    vc.viewModel = viewModel

    navigationController.viewControllers = [vc]
    topViewController?.present(navigationController, animated: true)
  }
}

// MARK: Home Navigation
extension YDNextLivesCoordinator: HomeNavigation {
  func onExit() {
    rootViewController.dismiss(animated: true, completion: nil)
  }
}
