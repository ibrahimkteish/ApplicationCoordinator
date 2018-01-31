import RxSwift

final class TabbarController: UITabBarController, UITabBarControllerDelegate, TabbarView {
  
  
  let onItemFlowSelect: PublishSubject<UINavigationController> = PublishSubject()
  let onViewDidLoad: PublishSubject<UINavigationController> = PublishSubject()
  let onSettingsFlowSelect: PublishSubject<UINavigationController> = PublishSubject()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    if let controller = customizableViewControllers?.first as? UINavigationController {
      onViewDidLoad.onNext(controller)
    }
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    guard let controller = viewControllers?[selectedIndex] as? UINavigationController else { return }
    
    if selectedIndex == 0 {
      onItemFlowSelect.onNext(controller)
    }
    else if selectedIndex == 1 {
      onSettingsFlowSelect.onNext(controller)
    }
  }
}
