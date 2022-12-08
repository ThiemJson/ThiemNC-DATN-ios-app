//
//  LoginViewController.swift
//  datn-app
//
//  Created by ThiemJason on 11/17/22.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import LocalAuthentication
import SVProgressHUD
import Hero

enum LoginViewControllerMode {
    case Lecture
    case Student
    case Choose
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var lblTitle             : UILabel!
    @IBOutlet weak var vContent             : UIView!
    @IBOutlet weak var lblLoginWith         : UILabel!
    
    @IBOutlet weak var vStudent             : UIView!
    @IBOutlet weak var vLecture             : UIView!
    @IBOutlet weak var lblStudent           : UILabel!
    @IBOutlet weak var lblLecture           : UILabel!
    
    @IBOutlet weak var imgUserMode          : UIImageView!
    @IBOutlet weak var vUserName            : TextFieldCustom!
    @IBOutlet weak var vPassword            : TextFieldCustom!
    @IBOutlet weak var btnLogin             : UIButton!
    
    @IBOutlet weak var vImgFastLogin        : UIView!
    @IBOutlet weak var imgFastLogin         : UIImageView!
    @IBOutlet weak var vLoginSite           : UIView!
    @IBOutlet weak var vPerson              : UIView!
    @IBOutlet weak var lblBack              : UILabel!
    @IBOutlet weak var btnBack              : UIButton!
    @IBOutlet weak var vBack                : UIView!
    
    @IBOutlet weak var vBotomImage          : UIView!
    let disposeBag                          = DisposeBag()
    let rxLoginMode                         = BehaviorRelay<LoginViewControllerMode>(value: .Choose)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializedContent()
    }
    
    private func initializedContent() {
        self.lblTitle.textColor             = .white
        self.vContent.layer.cornerRadius    = 24
        self.vContent.clipsToBounds         = true
        self.lblLoginWith.textColor         = Constant.Color.dark_blue
        self.lblLecture.textColor           = Constant.Color.dark_blue
        self.lblStudent.textColor           = Constant.Color.dark_blue
        self.lblBack.textColor              = Constant.Color.dark_blue
        
        switch LAContext.shared.biometricType {
        case .touchID:
            self.imgFastLogin.image         = UIImage(systemName: "touchid")
        case .faceID:
            self.imgFastLogin.image         = UIImage(systemName: "faceid")
        default:
            self.vImgFastLogin.isHidden     = true
        }
        
        self.lblTitle.font                  = UIFont.getOpenSansBoldFont(size: 20)
        self.lblBack.font                   = UIFont.getOpenSansBoldFont(size: 17)
        self.lblStudent.font                = UIFont.getOpenSansSemiBoldFontDefault()
        self.lblLoginWith.font              = UIFont.getOpenSansSemiBoldFontTitle()
        self.lblLecture.font                = UIFont.getOpenSansSemiBoldFontDefault()
        self.lblBack.font                   = UIFont.getOpenSansBoldFont(size: 18)
        
        self.vStudent.setShadowRadiusView()
        self.vLecture.setShadowRadiusView()
        self.vContent.backgroundColor       = Constant.Color.app_background
        self.vImgFastLogin.layer.cornerRadius   = 10
        self.vImgFastLogin.clipsToBounds    = true
        self.vImgFastLogin.layer.borderColor    = Constant.Color.hex_2D74E7.cgColor
        self.vImgFastLogin.layer.borderWidth    = 2
        self.vImgFastLogin.backgroundColor  = Constant.Color.app_background
        
        self.vUserName.isSecureTextField    = false
        self.vPassword.isSecureTextField    = true
        self.vUserName.updateUI()
        self.vPassword.updateUI()
        self.addTxtFieldDesign(textfield: self.vUserName.tfTextField, placeHolder: "Tài khoản")
        self.addTxtFieldDesign(textfield: self.vPassword.tfTextField, placeHolder: "Mật khẩu")
        self.btnLogin.setBorderButton("Đăng nhập", 10)
        
        self.vLoginSite.isHidden    = true
        self.vPerson.isHidden       = false
        
        self.setupBinding()
        self.handlerAction()
        
        self.vStudent.hero.modifiers = [.translate(y:100)]
        self.vLecture.hero.modifiers = [.translate(y:100)]
        self.imgUserMode.hero.modifiers = [.translate(x:100)]
    }
    
    private func handlerAction() {
        self.btnLogin.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
            guard let `self` = self else { return }
            
            var loginRequest                = LoginRequest()
            loginRequest.username           = self.vUserName.tfTextField.text ?? ""
            loginRequest.password           = self.vPassword.tfTextField.text ?? ""
            loginRequest.type               = (self.rxLoginMode.value == .Student) ? 1 : 0
            StudentRepository.shared.getUserByMSV(loginRequest: loginRequest) { [weak self] (studentResponse) in
                guard let `self` = self else { return }
                SVProgressHUD.dismiss()
                guard let studentResponse = studentResponse else {
                    DispatchQueue.main.async {
                        AppMessagesManager.shared.showMessage(messageType: .error, message: "Đăng nhập thất bại, vui lòng liên hệ Quản lý")
                    }
                    return
                }
                
                /// `Kiểm tra UUID`
                if let deviceUUID = studentResponse.deviceCode,
                   let currentDeviceUUID   = UIDevice.current.identifierForVendor?.uuidString {
                    
                    ///  `Đăng nhập trên thiết bị mới`
                    if deviceUUID != currentDeviceUUID {
                        let loadingPopup                        = PopupCustom()
                        loadingPopup.modalPresentationStyle     = .overFullScreen
                        loadingPopup.modalTransitionStyle       = .crossDissolve
                        loadingPopup.isAutoDissmis              = 10
                        self.present(loadingPopup, animated: true)
                    }
                    
                    /// `Thành công`
                    self.onLoginSuccess(studentResponse: studentResponse)
                }
                
                self.onLoginSuccess(studentResponse: studentResponse)
            }
        }).disposed(by: self.disposeBag)
        
        self.vImgFastLogin.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            let loadingPopup                        = PopupCustom()
            loadingPopup.modalPresentationStyle     = .overFullScreen
            loadingPopup.modalTransitionStyle       = .crossDissolve
            self.present(loadingPopup, animated: true)
        }).disposed(by: self.disposeBag)
        
        self.btnBack.rx.tap.asDriver().drive(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxLoginMode.accept(.Choose)
        }).disposed(by: self.disposeBag)
        
        self.vStudent.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxLoginMode.accept(.Student)
        }).disposed(by: self.disposeBag)
        
        self.vLecture.rx.tap().asObservable().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let `self` = self else { return }
            self.rxLoginMode.accept(.Lecture)
        }).disposed(by: self.disposeBag)
        
        Provider.shared.rxLoading.observe(on: MainScheduler.instance).subscribe(onNext: {(isLoading) in
            if (isLoading ?? false) {
                DispatchQueue.main.async {
                    SVProgressHUD.show()
                }
                return
            }
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func setupBinding() {
        self.rxLoginMode.asDriver().drive(onNext: { [weak self] (mode) in
            guard let `self` = self else { return }
            switch mode {
            case .Choose:
                self.vLoginSite.isHidden    = true
                self.vPerson.isHidden       = false
                self.vBotomImage.isHidden   = false
            case .Lecture:
                self.vLoginSite.isHidden    = false
                self.vPerson.isHidden       = true
                self.vBotomImage.isHidden   = true
                self.imgUserMode.image      = UIImage(named: "teacher")
                
            case .Student:
                self.vLoginSite.isHidden    = false
                self.vPerson.isHidden       = true
                self.vBotomImage.isHidden   = true
                self.imgUserMode.image      = UIImage(named: "student")
            }
            
            /// `Clear input`
            self.vUserName.tfTextField.text = ""
            self.vPassword.tfTextField.text = ""
            self.vPassword.rxIsShowContent.accept(false)
        }).disposed(by: self.disposeBag)
    }
}

extension LoginViewController {
    private func onLoginSuccess( studentResponse: StudentResponse? ) {
        
    }
}
