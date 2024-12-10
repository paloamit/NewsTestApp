import UIKit

extension UIImageView {
    func downLoadImage(url: URL) {
        if let image = ImageCache.shared.getImage(url: (url as NSURL)) {
            self.image = image
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let self = self else { return }
                if let data = data {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            self.image = image
                            ImageCache.shared.setImage(url: (url as NSURL), image: image)
                        }
                    }
                }
            }.resume()
        }
    }
}

extension UIViewController {
    func showAlert(title:String, message:String, actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension UIView {
    func createRoundedView(cornerRadius: CGFloat = 10.0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
