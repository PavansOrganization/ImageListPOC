//
//  Utility.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class Utility {
    /*
     we can use this method globaly to show any messages/Alerts.
     */
    static func showAlert(message: String, delegate: UIViewController?) {
        let alertController = UIAlertController(title: AppConstants.alertTitle, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: AppConstants.alertOK, style: .default, handler: nil))
        delegate?.present(alertController, animated: true, completion: nil)
    }
}
