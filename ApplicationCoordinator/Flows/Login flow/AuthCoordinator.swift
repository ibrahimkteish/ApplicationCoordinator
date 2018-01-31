
import RxSwift

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {
  let finishFlow: PublishSubject<Void> = PublishSubject()
  
  private let factory: AuthModuleFactory
  private let router: Router
  private weak var signUpView: SignUpView?
  
  private let disposeBag = DisposeBag()
  
  init(router: Router, factory: AuthModuleFactory) {
    self.factory = factory
    self.router = router
  }
  
  override func start() {
    showLogin()
  }
  
  //MARK: - Run current flow's controllers
  
  private func showLogin() {
    let loginOutput = factory.makeLoginOutput()
    loginOutput.onCompleteAuth.subscribe(onNext: { [weak self] (_) in
      self?.finishFlow.onNext(())
    }).disposed(by: disposeBag)
    
    loginOutput.onSignUpButtonTap.subscribe(onNext: { [weak self] Void in
       self?.showSignUp()
    }).disposed(by: disposeBag)
    
    router.setRootModule(loginOutput)
  }
  
  private func showSignUp() {
    signUpView = factory.makeSignUpHandler()
    signUpView?.onSignUpComplete.subscribe(onNext: { [weak self] in
      self?.finishFlow.onNext(())
    }).disposed(by: disposeBag)
    
    signUpView?.onTermsButtonTap.subscribe(onNext: { [weak self] in
      self?.showTerms()
    }).disposed(by: disposeBag)
    router.push(signUpView)
  }
  
  private func showTerms() {
    let termsOutput = factory.makeTermsOutput()

    termsOutput.onConfirmChanged
    .subscribe(onNext: { [weak self] confirmed in
        self?.signUpView?.onConformToTermsAgreement.onNext(confirmed)
    }).disposed(by: disposeBag)
    router.push(termsOutput, animated: true)
  }
}
