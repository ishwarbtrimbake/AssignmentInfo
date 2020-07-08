import Foundation
import UIKit

extension UIViewController {
    
    /// This common function to show alert.
    /// - Parameter message: Contains info to show user.
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "Facts", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}
