//
//  UIViewController+ActivityIndicator.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    enum Constants {
        static let activityIndicatorTag = 999999
    }

    func showLoading(_ show: Bool){
        if show {
            startActivityIndicator()
        } else {
            stopActivityIndicator()
        }
    }
    
    func startActivityIndicator(
        style: UIActivityIndicatorView.Style = .gray,
        location: CGPoint? = nil) {
        
        let loc = location ?? self.view.center
        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: style)

            activityIndicator.tag = Constants.activityIndicatorTag

            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true

            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        guard let subview = self.view.subviews.filter({ $0.tag == Constants.activityIndicatorTag}).first,
            let activityIndicator = subview as? UIActivityIndicatorView else { return }
        
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
