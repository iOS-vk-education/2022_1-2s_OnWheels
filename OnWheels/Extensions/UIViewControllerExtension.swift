//
//  UIViewControllerExtension.swift
//  OnWheels
//
//  Created by Veronika on 24.05.2023.
//

import UIKit

extension UIViewController {
    func showLoader() {
        let loader = LoaderView()
        
        self.view.addSubview(loader)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        loader.startAnimation()
    }
    
    func hideLoader() {
        let loader = self.view.subviews.first { $0 is LoaderView }
        loader?.removeFromSuperview()
    }
    
    func showLoaderIfNeeded(isLoading: Bool) {
        if isLoading {
            showLoader()
        } else {
            hideLoader()
        }
    }
}
