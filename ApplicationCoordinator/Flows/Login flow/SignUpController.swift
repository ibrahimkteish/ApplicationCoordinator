import RxSwift

final class SignUpController: UIViewController, SignUpView {
  private let disposeBag = DisposeBag()
  //controller handler
  let onSignUpComplete = PublishSubject<Void>()
  let onTermsButtonTap =  PublishSubject<Void>()
  let onConformToTermsAgreement = PublishSubject<Bool>()
  @IBOutlet weak var termsLabel: UILabel!
  @IBOutlet weak var signUpButton: UIButton!
  @IBOutlet weak var terms: UIButton!
  
//  var confirmed = false {
//    didSet {
//      termsLabel.isHidden = !confirmed
//      signUpButton.isEnabled = confirmed
//    }
//  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "SignUp"
    termsLabel.isHidden = true
    signUpButton.isEnabled = false
    onConformToTermsAgreement.subscribe(onNext: { [weak self] (confirmed) in
      self?.termsLabel.isHidden = !confirmed
      self?.signUpButton.isEnabled = confirmed
    }).disposed(by: disposeBag)
    
    signUpButton.rx.tap.bind(to: onSignUpComplete).disposed(by: disposeBag)
    terms.rx.tap.bind(to: onTermsButtonTap).disposed(by: disposeBag)
  }
}
