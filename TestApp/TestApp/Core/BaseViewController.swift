import UIKit

class BaseViewController: UIViewController, BaseStoryboard {
    class var storyboardName: String {
        fatalError("storyboard name is not defined")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
