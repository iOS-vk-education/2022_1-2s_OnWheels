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
    
    let fields = ["Имя", "Фамилия", "Дата рождения", "Пол", "Город", "Почта", "Пароль", "Подтверждение пароля"]
    
    private let backButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(R.image.backButton(), for: .normal)
        back.clipsToBounds = true
        back.tintColor = R.color.mainBlue()
        back.isEnabled = true
        return back
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private let contentView = UIView()
    
    private let regContentView = RegistrationContentView()
    
    private var registrationScrollViewConstraint: NSLayoutConstraint?
    
    init(output: RegistrationViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .systemBackground
        addViews()
        setupLayout()
        setupBindings()
        setupBackButton()
        setupObserversForKeyboard()
        setupGestureRecognizer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let widthFrame = scrollView.frame.width
        let height = regContentView.frame.height
        scrollView.contentSize = CGSize(width: widthFrame,
                                        height: height)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = contentInset
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentInset = contentInset
        }
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
}


private extension RegistrationViewController {
    func setupLayout() {
        regContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            regContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            regContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            regContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            regContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            regContentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            regContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 70),
            
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        registrationScrollViewConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    }
    
    func setupBindings() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        setupAction()
    }
    
    func setupAction(){
        regContentView.setRegisterAction { [weak self] info in
            self?.output.didTapRegButton(regInfo: info)
        }
    }
    
    func setupBackButton() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    func setupGestureRecognizer(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func addViews() {
        view.addSubview(scrollView)
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
    func showEmptyFields(withIndexes indexes: [Int]){
        var emptyFields = ""
        for index in indexes {
            emptyFields.append("\(fields[index]), ")
        }
        let alert = UIAlertController(title: "Ой", message: "Проверьте заполненность полей: \(emptyFields)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Исправлю", style: .default))
        self.present(alert, animated: true)
    }
    
    func showCheckedPassword(){
        let alert = UIAlertController(title: "Ой", message: "Пароли не совпаадают", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Исправлю", style: .default))
        self.present(alert, animated: true)
    }
}
