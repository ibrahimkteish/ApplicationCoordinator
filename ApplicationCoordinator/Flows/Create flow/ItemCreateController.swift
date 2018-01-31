import RxSwift

final class ItemCreateController: UIViewController, ItemCreateView {
  
  //controller handler
  let onHideButtonTap = PublishSubject<Void>()
  let onCompleteCreateItem = PublishSubject<ItemList>()
  private let disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Create"
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: nil, action: nil)
    navigationItem.leftBarButtonItem?.rx.tap.bind(to: onHideButtonTap).disposed(by: disposeBag)
  }
  
  @IBAction func createButtonClicked(_ sender: UIBarButtonItem) {
    onCompleteCreateItem.onNext(ItemList(title: "", subtitle: ""))
  }
}
