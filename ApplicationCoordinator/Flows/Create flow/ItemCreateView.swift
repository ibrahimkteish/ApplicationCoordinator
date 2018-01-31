import RxSwift

protocol ItemCreateView: BaseView {
  var onHideButtonTap: PublishSubject<Void> { get }
  var onCompleteCreateItem: PublishSubject<ItemList> { get }
}
