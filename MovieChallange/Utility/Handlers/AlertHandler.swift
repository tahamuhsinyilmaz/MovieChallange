//
//  AlertHandler.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit
class AlertHandler{
    class func showAlert(vc: UIViewController, title: String?, message: String){
        let alertController = UIAlertController(title: title ?? "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Strings.shared.okay, style: .cancel, handler: nil))
        vc.present(alertController, animated: true, completion: nil)
    }
}
