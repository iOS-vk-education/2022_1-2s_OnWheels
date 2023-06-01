//
//  MyEventsRouter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//
//

import UIKit

final class AddEventRouter {
    var viewController: UIViewController?
    private var imagePicker: ImagePicker?
}

extension AddEventRouter: AddEventRouterInput {
    func didTapCloseButton() {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: true)
        }
    }
    
    func didTapAddButton() {
        DispatchQueue.main.async {
            self.viewController?.dismiss(animated: true)
        }
    }
    
    func showImagePicker(delegateForPicker delegate: ImagePickerDelegate) {
        guard let viewController = viewController else { return }
        imagePicker = ImagePicker(presentationController: viewController, delegate: delegate)
        imagePicker?.present(from: viewController.view)
    }
}
