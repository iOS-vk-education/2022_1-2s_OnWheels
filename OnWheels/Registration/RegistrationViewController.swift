//
//  RegistrationViewController.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import UIKit

final class RegistrationViewController: UIViewController, UIGestureRecognizerDelegate {
    private let output: RegistrationViewOutput

    private let backButton: UIButton = {
        let back = UIButton()
        back.setImage(R.image.backButton(), for: .normal)
        back.clipsToBounds = true
        back.tintColor = R.color.mainBlue()
        back.isEnabled = true
        return back
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let s: UIScrollView = .init()
        return s
    }()
    
    private let regContentView = RegistrationContentView()
    
    private let genderData = [ R.string.localizable.man(), R.string.localizable.woman()]
    
    init(output: RegistrationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardSize.cgRectValue.height
        if scrollView.frame.origin.y == 0 {
            UIView.animate(withDuration: 0.3){ [weak self] in
                self?.scrollView.frame.origin.y -= keyboardHeight
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.frame.origin.y = 0
    }
    
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func backButtonTapped(){
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.backButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.backButtonAction()
                self?.backButton.alpha = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        addViews()
        setupBindings()
        setupBackButton()
        setupObserversForKeyboard()
        setupGestureRecognizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }
    
    @objc
    private func didTapRegButton() {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.regContentView.registrationButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapRegButton()
                self?.regContentView.registrationButton.alpha = 1
            }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupLayout()
        
        let widthFrame = regContentView.frame.width
        let height = regContentView.frame.height
        scrollView.contentSize = CGSize(width: widthFrame,
                                        height: height + 100)
    }
}


private extension RegistrationViewController {
    func setupLayout() {
        scrollView.pin
            .all()
        
        regContentView.pin
            .all()
        
        backButton.pin
            .top()
            .left(20)
            .height(35)
            .width(35)
    }
    
    func setupBindings() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        regContentView.registrationButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
    }
    
    func setupBackButton() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setupGestureRecognizer(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func addViews() {
        scrollView.addSubview(regContentView)
        scrollView.addSubview(backButton)
    }
    
    func setupObserversForKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserversForKeyboard(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: self.view.window)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: self.view.window)
    }
}

extension RegistrationViewController: RegistrationViewInput {
}
