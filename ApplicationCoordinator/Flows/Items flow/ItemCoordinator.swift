import RxSwift

final class ItemCoordinator: BaseCoordinator {
  
  private let disposeBag = DisposeBag()
  private let factory: ItemModuleFactory
  private let coordinatorFactory: CoordinatorFactory
  private let router: Router
  init(router: Router, factory: ItemModuleFactory, coordinatorFactory: CoordinatorFactory) {
    self.router = router
    self.factory = factory
    self.coordinatorFactory = coordinatorFactory
  }
  
  override func start() {
    showItemList()
  }
  
  //MARK: - Run current flow's controllers
  
  private func showItemList() {
    
    let itemsOutput = factory.makeItemsOutput()
    itemsOutput.onItemSelect.subscribe(onNext: { [weak self] (item) in
      self?.showItemDetail(item)
    }).disposed(by: disposeBag)
    
    itemsOutput.onCreateItem.subscribe(onNext: { [weak self] (_) in
      self?.runCreationFlow()
    }).disposed(by: disposeBag)
    
    router.setRootModule(itemsOutput)
  }
  
  private func showItemDetail(_ item: ItemList) {
    
    let itemDetailFlowOutput = factory.makeItemDetailOutput(item: item)
    router.push(itemDetailFlowOutput)
  }
  
  //MARK: - Run coordinators (switch to another flow)
  
  private func runCreationFlow() {
    
    let (coordinator, module) = coordinatorFactory.makeItemCreationCoordinatorBox()
    coordinator.finishFlow.subscribe(onNext: { [weak self, weak coordinator] (item) in
      
      self?.router.dismissModule()
      self?.removeDependency(coordinator)
      if let item = item {
        self?.showItemDetail(item)
      }
    }).disposed(by: coordinator.disposeBag)
    
    addDependency(coordinator)
    router.present(module)
    coordinator.start()
  }
}
