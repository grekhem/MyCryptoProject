import Foundation
import UIKit

final class AuthorizationViewController: UIViewController {
    
    private var presenter: IAuthorizationPresenter?
    private var customView = AuthorizationView()
    
    init(presenter: IAuthorizationPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        self.customView.backgroundColor = Color.gray.color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chechAuth()
    }
    
    override func loadView() {
        self.view = customView
        self.presenter?.viewDidLoad(ui: customView)
        self.presenter?.openResetPasswordAlert = { [weak self] in
            guard let self = self else { return }
            self.alertResetPassword()
        }
        self.presenter?.openResetSuccessAlert = { [weak self] in
            guard let self = self else { return }
            self.passwordResetSuccess()
        }
    }
    
    
}

private extension AuthorizationViewController {
    func passwordResetSuccess() {
        let alert = UIAlertController(title: "", message: "Пароль успешно сброшен\nПроверьте почту", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func alertResetPassword() {
        let alert = UIAlertController(title: "Сброс пароля", message: "Введите email", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "email"
        }
        let resetButton = UIAlertAction(title: "Reset", style: .default) { _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self.presenter?.resetPassword(email: text)
            }
        }
        alert.addAction(resetButton)
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    private func chechAuth() {
        if self.presenter?.checkAuth() == true {
            self.presenter?.openApp()
        }
    }
}

