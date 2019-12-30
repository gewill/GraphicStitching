
import UIKit

func gs_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    UIApplication.shared.keyWindow?.rootViewController?.present(viewControllerToPresent, animated: flag, completion: completion)
}
