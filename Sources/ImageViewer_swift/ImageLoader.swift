import Foundation
#if canImport(Kingfisher)
import Kingfisher
#endif

public protocol ImageLoader {
    func loadImage(_ url: URL, placeholder: UIImage?, imageView: UIImageView, completion: @escaping (_ image: UIImage?) -> Void)
}

public struct URLSessionImageLoader: ImageLoader {
    public init() {}

    public func loadImage(_ url: URL, placeholder: UIImage?, imageView: UIImageView, completion: @escaping (UIImage?) -> Void) {
        if let placeholder = placeholder {
            imageView.image = placeholder
        }

        DispatchQueue.global(qos: .background).async {
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                imageView.image = image
                completion(image)
            }
        }
    }
}

#if canImport(Kingfisher)
struct KingfisherImageLoader: ImageLoader {
    func loadImage(_ url: URL, placeholder: UIImage?, imageView: UIImageView, completion: @escaping (UIImage?) -> Void) {
        imageView.kf.setImage(with: url, placeholder: placeholder) { result in
            switch result {
            case .success(let result):
                UIView.setAnimationsEnabled(false)
                completion(result.image)
                UIView.setAnimationsEnabled(true)
            case .failure:
                completion(nil)
            }
            completion(nil)
        }
    }
}
#endif
