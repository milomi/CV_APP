//
//  ViewControllerContainer.swift
//  OSOM_app
//
//  Created by Miłosz Bugla on 18/07/2017.
//  Copyright © 2017 ITEO Sp. z o.o. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerContainer {
    
    func getWelcome() -> UIViewController {
        return WelcomeScreenViewController(viewModel: WelcomeScreenViewModelImpl(), mainView: WelcomeView())
    }
    
}
