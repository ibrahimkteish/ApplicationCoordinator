import RxSwift

class TabbarCoordinator: BaseCoordinator {
  
  private let disposeBag = DisposeBag()
  
  private let tabbarView: TabbarView
  private let coordinatorFactory: CoordinatorFactory
  
  init(tabbarView: TabbarView, coordinatorFactory: CoordinatorFactory) {
    self.tabbarView = tabbarView
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    tabbarView.onViewDidLoad.subscribe(onNext: { [weak self] (navController) in
      if navController.viewControllers.isEmpty == true {
        guard let itemCoordinator = self?.coordinatorFactory.makeItemCoordinator(navController: navController) else { return }
        itemCoordinator.start()
        self?.addDependency(itemCoordinator)
      }
    }).disposed(by: disposeBag)
    
    tabbarView.onItemFlowSelect.subscribe(onNext: { [weak self] (navController) in
      if navController.viewControllers.isEmpty == true {
        guard let itemCoordinator = self?.coordinatorFactory.makeItemCoordinator(navController: navController) else { return }
        itemCoordinator.start()
        self?.addDependency(itemCoordinator)
      }
    }).disposed(by: disposeBag)
    
    tabbarView.onSettingsFlowSelect.subscribe(onNext: { [weak self] (navController) in
      if navController.viewControllers.isEmpty == true {
        guard let settingsCoordinator = self?.coordinatorFactory.makeSettingsCoordinator(navController: navController) else { return }
        settingsCoordinator.start()
        self?.addDependency(settingsCoordinator)
      }
    }).disposed(by: disposeBag)
  }
}
