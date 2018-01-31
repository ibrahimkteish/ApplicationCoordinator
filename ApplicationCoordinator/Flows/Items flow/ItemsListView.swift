import RxSwift

protocol ItemsListView: BaseView {
  var onItemSelect: PublishSubject<ItemList> { get }
  var onCreateItem: PublishSubject<Void> { get }
}
