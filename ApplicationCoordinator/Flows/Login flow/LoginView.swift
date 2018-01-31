import RxSwift

protocol LoginView: BaseView {
  var onCompleteAuth: PublishSubject<Void> { get }
  var onSignUpButtonTap: PublishSubject<Void> { get }
}
