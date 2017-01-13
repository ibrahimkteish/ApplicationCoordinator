final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {
  
  var finishFlow: (()->())?
  
  private let factory: AuthModuleFactory
  private let router: Router
  private weak var signUpView: SignUpView?
  
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
    loginOutput.onCompleteAuth = { [weak self] in
      self?.finishFlow?()
    }
    loginOutput.onSignUpButtonTap = { [weak self] in
      self?.showSignUp()
    }
    router.setRootModule(loginOutput)
  }
  
  private func showSignUp() {
    signUpView = factory.makeSignUpHandler()
    signUpView?.onSignUpComplete = { [weak self] in
      self?.finishFlow?()
    }
    signUpView?.onTermsButtonTap = { [weak self] in
      self?.showTerms()
    }
    router.push(signUpView)
  }
  
  private func showTerms() {
    let termsOutput = factory.makeTermsOutput()
    router.push(termsOutput, animated: true) { [weak self] in
      self?.signUpView?.conformTermsAgreement(termsOutput.confirmed)
    }
  }
}
