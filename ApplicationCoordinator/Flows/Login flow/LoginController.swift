import RxSwift

final class LoginController: UIViewController, LoginView {

  @IBOutlet weak var login: UIButton!
  @IBOutlet weak var signUp: UIButton!
  //controller handler
  let onCompleteAuth: PublishSubject<Void> = PublishSubject()
  let onSignUpButtonTap: PublishSubject<Void> = PublishSubject()
  private let disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Login"
    
    login.rx.tap.bind(to: onCompleteAuth).disposed(by: disposeBag)
    signUp.rx.tap.bind(to: onSignUpButtonTap).disposed(by: disposeBag)
  }
}
