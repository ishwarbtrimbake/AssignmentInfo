import Foundation

extension String {
    
    /// This function converts string to localized string.
    /// - Parameter comment: String data which has to be localized.
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

}
