import  RxSwift
protocol SignUpView: BaseView {
  
  var onSignUpComplete: PublishSubject<Void> { get }
  var onTermsButtonTap: PublishSubject<Void> { get }
  
  var onConformToTermsAgreement: PublishSubject<Bool> { get }
}
