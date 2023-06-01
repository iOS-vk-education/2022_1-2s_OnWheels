//
//  UIViewControllerExtension.swift
//  OnWheels
//
//  Created by Veronika on 24.05.2023.
//

import UIKit

extension UIViewController {
    func showLoader(animationName: String) {
        let loader = LoaderView(animationName: animationName)
        
        self.view.addSubview(loader)
        
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        loader.startAnimation()
    }
    
    func hideLoader() {
        let loader = self.view.subviews.first { $0 is LoaderView }
        loader?.removeFromSuperview()
    }

    func scaleLoader(scaleCoeff: Double) {
        let loader = self.view.subviews.first { $0 is LoaderView } as! LoaderView
        loader.scaleConstraints(scaleCoeff: scaleCoeff)
    }
    
    func showLoaderIfNeeded(isLoading: Bool, animationName: String) {
        if isLoading {
            showLoader(animationName: animationName)
        } else {
            hideLoader()
        }
    }
}
