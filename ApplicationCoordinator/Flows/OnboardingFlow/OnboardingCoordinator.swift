import RxSwift

class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {

  let finishFlow = PublishSubject<Void>()
  
  private let factory: OnboardingModuleFactory
  private let router: Router
  
  init(with factory: OnboardingModuleFactory, router: Router) {
    self.factory = factory
    self.router = router
  }
  
  override func start() {
    showOnboarding()
  }
  
  func showOnboarding() {
    let onboardingModule = factory.makeOnboardingModule()
    onboardingModule.onFinish.subscribe(onNext: { [weak self] in
      self?.finishFlow.onNext(())
    })
    router.setRootModule(onboardingModule.toPresent())
  }
}
