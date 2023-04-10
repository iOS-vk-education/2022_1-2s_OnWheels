//
// Created by Артём on 03.04.2023.
//

import UIKit

final class ProfileViewController: UIViewController {
    private lazy var profileView = ProfileContentView(frame: .zero)
    private let presenter: ProfilePresenter
    
    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
    }

    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.presenter.update()
    }
}


extension ProfileViewController: ProfileView {
    // эту функцию дергает презентер
    func setUserInfo(user: CurrentUser) {
        // profileView.updateUserName(with: str)
    }
}


private extension ProfileViewController {
    func setupActions() {
        // здесь буду коллы к самой вьюшке, чтобы связать действия презентера на нажатия кнопок
        // profileView.setProfileDetailButtonAction(self.presenter.navigateToProfileDetails)
    }
}
