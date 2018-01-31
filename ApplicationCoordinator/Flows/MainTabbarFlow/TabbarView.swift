
import RxSwift

protocol TabbarView: class {
  var onItemFlowSelect: PublishSubject<UINavigationController> { get }
  var onSettingsFlowSelect: PublishSubject<UINavigationController> { get }
  var onViewDidLoad: PublishSubject<UINavigationController> { get }
}
