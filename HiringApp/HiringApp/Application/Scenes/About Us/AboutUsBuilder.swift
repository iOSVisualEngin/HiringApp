//
//  AboutUsBuilder.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 13/07/2017.
//  Copyright (c) 2017 Visual Engineering. All rights reserved.
//

import Foundation
//import Deferred

protocol AboutUsPresenterProtocol {
    func viewDidLoad()
}

protocol AboutUsInteractorProtocol {
    //    func retrieveData() -> Task<AboutUsViewModel>
}

protocol AboutUsUserInterfaceProtocol: class {

}

protocol AboutUsRouterProtocol {
    func navigateToNextScene()
}

class AboutUsBuilder {

    //MARK: - Configuration
    static func build() -> AboutUsViewController {
        let viewController = AboutUsViewController()
        let router = AboutUsRouter(view: viewController)
        let interactor = AboutUsInteractor()
        let presenter = AboutUsPresenter(router: router, interactor: interactor, view: viewController)

        viewController.presenter = presenter

        return viewController
    }
}
