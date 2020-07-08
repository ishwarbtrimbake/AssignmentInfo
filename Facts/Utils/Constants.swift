import Foundation

/// This struct maintains all constant used in an app.
struct Constants {
    //Base URL
    static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    
    /// This struct has all the string messages used in an app.
    struct Messages {
        static let dataFailure = "Failed to get data."
        static let internetConnectionFailure = "You are offline. Please check your internet connection."
        static let fatalError = "Something went wrong. Please try again."
    }
}
