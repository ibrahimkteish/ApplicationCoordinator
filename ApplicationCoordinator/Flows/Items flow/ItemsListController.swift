import RxSwift
import RxCocoa

final class ItemsListController: UIViewController, ItemsListView {
  
  //controller handler
  let onItemSelect = PublishSubject<ItemList>()
  let onCreateItem = PublishSubject<Void>()
  private let disposeBag = DisposeBag()
    
  @IBOutlet weak var tableView: UITableView!
  //mock datasource
  var items = (0...10).map { index in return ItemList(title: "Item № \(index)", subtitle: "Item descripton") }
  var authCheck = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Items"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: nil,
      action: nil)
    navigationItem.rightBarButtonItem?.rx.tap.bind(to: onCreateItem).disposed(by: disposeBag)
  }
}

extension ItemsListController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let item = items[(indexPath as NSIndexPath).row]
    cell.textLabel?.text = item.title
    cell.detailTextLabel?.text = item.subtitle
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    onItemSelect.onNext(items[(indexPath as NSIndexPath).row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
