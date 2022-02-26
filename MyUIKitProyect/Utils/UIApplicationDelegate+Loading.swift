//
//  UIApplicationDelegate+Loading.swift
//  MyBusinessFinderUIKit
//
//  Created by Fernando Corral on 5/1/22.
//

import UIKit
import NVActivityIndicatorView

public extension UIApplication {
    //Show loading
    @objc func showLoading() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance
                               .startAnimating(.init(size: .init(width: 50, height: 50),
                                                     message: nil,
                                                     messageFont: nil,
                                                     messageSpacing: nil,
                                                     type: .circleStrokeSpin,
                                                     color: .label,
                                                     padding: nil,
                                                     displayTimeThreshold: 1,
                                                     minimumDisplayTime: nil,
                                                     backgroundColor: UIColor.systemBackground.withAlphaComponent(0.5),
                                                     textColor: nil))
        }
    }
    
    //Hide loading
    @objc func hideLoading() {
        DispatchQueue.main.async {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }
}
