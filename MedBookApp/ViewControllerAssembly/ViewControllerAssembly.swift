//
//  ViewControllerAssembly.swift
//  MedBookApp
//
//  Created by Amitesh Mani Tiwari on 29/03/24.
//

import UIKit

class ViewControllerAssembly {
    
    static func makeLandingViewController(coordinator: MainCoordinator, router: LandingRouting) -> UIViewController {
        let viewModel = LandingViewModel(routing: router)
        let viewController = LandingViewController(viewModel: viewModel)
        return viewController
    }
    
    static func makeSignupViewController(router: SignupPageRoutingLogic) -> UIViewController {
        let viewModel = SignupPageViewModel(countryService: CountryService(),
                                            router: router)
        let viewController = SignupPageViewController(viewModel: viewModel)
        return viewController
    }
    
    static func makeLoginViewController(router: LoginPageRoutingLogic) -> UIViewController {
        let viewModel = LoginPageViewModel(router: router)
        let viewController = LoginPageViewController(viewModel: viewModel)
        return viewController
    }
    
    static func makeHomeViewController(router: HomeScreenRouting) -> UIViewController {
        let viewModel = HomeScreenViewModel(router: router)
        let viewController = HomeScreenViewController(viewModel: viewModel)
        return viewController
    }
    
    static func makeBookmarkScreenController(router: BookmarkScreenRoutingLogic) -> UIViewController {
        let viewModel = BookmarkScreenViewModel(router: router)
        let viewController = BookmarkScreenViewController(viewModel: viewModel)
        return viewController
    }

}
