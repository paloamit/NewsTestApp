import UIKit

public protocol BaseStoryboard: AnyObject {
    static var sceneStoryboard: UIStoryboard { get }
    static var storyboardName: String { get }
    static var storyboardBundle: Bundle { get }
    static var sceneIdentifier: String { get }
}

public extension BaseStoryboard {
    static var sceneStoryboard: UIStoryboard { UIStoryboard(name: storyboardName, bundle: storyboardBundle) }
    static var storyboardBundle: Bundle { Bundle(for: self) }
    static var sceneIdentifier: String { String(describing: self) }
}

public extension BaseStoryboard {
    static func instantiate() -> Self {
        let viewController = sceneStoryboard.instantiateViewController(withIdentifier: sceneIdentifier)
        guard let typedViewController = viewController as? Self else {
            fatalError("ViewController '\(sceneIdentifier)' of '\(sceneStoryboard)' is not of class '\(self)'")
        }
        return typedViewController
    }
}
