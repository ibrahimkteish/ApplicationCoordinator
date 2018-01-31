import RxSwift

protocol OnboardingView: BaseView {
  var onFinish: PublishSubject<Void> { get }
}
