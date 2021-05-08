//
//  ViewController.swift
//  messager
//
//  Created by ecinar on 4.05.2021.
//

import UIKit
import ProgressHUD


class LoginViewController: UIViewController {
    
    
    //labels
    @IBOutlet weak var emailLabelOutlet: UILabel!
    
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    
    //textfields
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var repeatPasswordTextfield: UITextField!
    
    //Buttons
    
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    //Views
    
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    var isLogin: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUiFor(login: true)
        setupTextFieldDelegates()
        setupBackgroundTap()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if isDataInputedFor(type: isLogin ? "login" : "register") {
            print("have data to all")
        }else {
            ProgressHUD.showFailed("All fields are required")
            
        }
        
    }
    
    
    @IBAction func resendEmailButtonPressed(_ sender: UIButton) {
        if isDataInputedFor(type: "passwod") {
            print("have data to passwod")
        }else {
            ProgressHUD.showFailed("Email field required")
            
        }
    }
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUiFor(login: sender.titleLabel?.text == "Login")
        isLogin.toggle()
    }
    @IBAction func forgotPasswodButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "passwod") {
            print("have data to passwod")
            
            
        }else {
            ProgressHUD.showFailed("Email field required")
            
            
            
            
            
            
        }
    }
    private func setupTextFieldDelegates() ->  Void {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        repeatPasswordTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textfield:UITextField){
        updatePlaceholderLabels(textField: textfield)
        
    }
    
    private func setupBackgroundTap(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap(){
        view.endEditing(false)
    }
    
    
    private func updateUiFor(login: Bool){
        loginButtonOutlet.setImage(UIImage(named: login ? "loginBtn" : "registerBtn"), for: .normal)
        
        signUpButtonOutlet.setTitle(login ? "SignUp" : "Login" , for: .normal)
        
        signUpLabel.text = login ? "Don't have an account ?" : "Have an account?"
        
        UIView.animate(withDuration: 0.5){
            self.repeatPasswordLabel.isHidden = login
            self.repeatPasswordTextfield.isHidden = login
            self.repeatPasswordLineView.isHidden = login
        }
        
    }
    
    private func updatePlaceholderLabels(textField:UITextField){
        switch textField {
        case emailTextField:
            emailLabelOutlet.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLabelOutlet.text = textField.hasText ? "Password" : ""
        default:
            repeatPasswordLabel.text = textField.hasText ? "Repeat Password" : ""
        }
    }
    //MARK: -Helpers
    
    private func isDataInputedFor(type: String) ->Bool{
        switch type {
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
        case "registration":
            return emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextfield.text != ""
        default:
            return emailTextField.text != ""
        }
    }
}

