import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private let cachedImages = NSCache<NSURL, UIImage>()

    private init() { }

    final func getImage(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }

    final func setImage(url: NSURL, image: UIImage) {
        return cachedImages.setObject(image, forKey: url)
    }

    final func clearCache() {
        cachedImages.removeAllObjects()
    }
}

