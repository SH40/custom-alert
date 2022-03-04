
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //ex ▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽▽
        let alertVC = UAlertController(title: "Alert", message: "message ...")
        let alertActionYes = UAlertAction(title: "Yes", style: .standard) {
            print("click yes")
        }
        let alertActionNo = UAlertAction(title: "No", style: .standard) {
            print("click no")
        }
        alertVC.addAction(alertActionYes)
        alertVC.addAction(alertActionNo)
        
        self.present(alertVC, animated: true, completion: nil)
        //△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△△
    }
}

