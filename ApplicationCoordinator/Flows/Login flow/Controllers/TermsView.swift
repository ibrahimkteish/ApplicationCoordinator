import RxSwift

protocol TermsView: BaseView {
  var onConfirmChanged: PublishSubject<Bool> { get }
}
