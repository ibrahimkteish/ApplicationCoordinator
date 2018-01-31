import RxSwift

protocol OnboardingCoordinatorOutput: class {
  var finishFlow: PublishSubject<Void> { get }
}
