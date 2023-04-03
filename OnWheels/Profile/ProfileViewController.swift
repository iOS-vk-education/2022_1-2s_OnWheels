//
// Created by Артём on 03.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    private var prView = ProfileView(frame: .zero)

    private let presenter: ProfilePresenter
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
        self.presenter.setVC(vc: self)
        self.presenter.update()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

private extension ProfileViewController {
    func setupActions() {
        // здесь буду коллы к самой вьюшке, чтобы связать действия презентера на нажатия кнопок
        // profileView.setProfileDetailButtonAction(self.presenter.navigateToProfileDetails)
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    // эту функцию дергает презентер
    func setUserInfo(user: CurrentUser) {
        // profileView.updateUserName(with: str)
    }
}


//// MARK: - keyboard hiding
//extension ProfileViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        authView.passwordFieldResignFirstResponder() || authView.loginFieldResignFirstResponder()
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
//}