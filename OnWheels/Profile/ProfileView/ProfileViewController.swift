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
        view = profileView
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
    func setUserInfo(user: ProfileUserInfo) {
        profileView.setUserInfo(user:user)
    }
}


private extension ProfileViewController {
    func setupActions() {
        profileView.setLogoutAction(self.presenter.logout)
        profileView.setDeleteAction(self.presenter.deleteAccount)
    }
}
