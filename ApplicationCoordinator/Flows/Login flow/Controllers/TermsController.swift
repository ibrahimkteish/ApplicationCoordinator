import RxSwift
import RxCocoa

class TermsController: UIViewController, TermsView {
  private let disposeBag = DisposeBag()
  @IBOutlet weak var termsSwitch: UISwitch!
  
  let onConfirmChanged = PublishSubject<Bool>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.termsSwitch.rx.isOn.bind(to: onConfirmChanged).disposed(by: disposeBag)
  }
}
