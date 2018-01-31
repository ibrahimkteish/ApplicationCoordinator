import RxSwift

protocol AuthCoordinatorOutput: class {
  var finishFlow: PublishSubject<Void> { get }
}
