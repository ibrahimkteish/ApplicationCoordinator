import RxSwift

final class ItemCreateCoordinator: BaseCoordinator, ItemCreateCoordinatorOutput {
  
  let finishFlow = PublishSubject<ItemList?>()
  let disposeBag = DisposeBag()
  private let factory: ItemCreateModuleFactory
  private let router: Router
  
  init(router: Router, factory: ItemCreateModuleFactory) {
    self.factory = factory
    self.router = router
  }
  
  override func start() {
    showCreate()
  }
  
  //MARK: - Run current flow's controllers
  
  private func showCreate() {
    let createItemOutput = factory.makeItemAddOutput()
    createItemOutput.onCompleteCreateItem.subscribe(onNext: { [weak self] item in
      self?.finishFlow.onNext(item)
    }).disposed(by: disposeBag)
    
    createItemOutput.onHideButtonTap.subscribe(onNext:{ [weak self] in
      self?.finishFlow.onNext(nil)
    }).disposed(by: disposeBag)
    
    router.setRootModule(createItemOutput)
  }
}
