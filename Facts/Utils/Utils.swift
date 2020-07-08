import Foundation
import Alamofire

/// This Utility checks whether device is connected to Internet or not.
struct Connectivity {
    
    static let shared = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.shared.isReachable
    }
}
