import RxSwift
import RxCocoa
class OnboardingController: UIViewController, OnboardingView {
  
  @IBOutlet weak var gotIt: UIButton!
  let onFinish = PublishSubject<Void>()
  private let disposeBag = DisposeBag()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gotIt.rx.tap.bind(to: onFinish).disposed(by: disposeBag)
  }
}
