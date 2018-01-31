import RxSwift
protocol ItemCreateCoordinatorOutput: class {
  var finishFlow: PublishSubject<ItemList?> { get }
  var disposeBag: DisposeBag { get }

}
