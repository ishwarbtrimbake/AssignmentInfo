import Foundation
import Moya

/// FactsViewModel performs networking operation for fething facts and handles errors.
/// JSON to Model conversion has been done using Codable
/// Operartion completions are handled by blocks.
class FactsViewModel {
    
    private let provider = MoyaProvider<FactType>()
    var onError: ((String) -> Void)?
    var onFactsLoading: ((FactsResponse) -> Void)?
    
    /// This function fetched facts using Moya TargetType
    /// - Parameter completion: returns `result` of type `FactResponse` and `Error`
    func getFacts(_ completion: ((Result<FactsResponse, Error>) -> Void)? = nil) {
        provider.request(.getFacts) { (result) in
            switch result {
            case .success(let value):
                do {
                    guard let utf8Data = String(decoding: value.data, as: UTF8.self).data(using: .utf8) else {
                        self.onError?(Constants.Messages.fatalError.localized())
                        return
                    }
                    let response = try JSONDecoder().decode(FactsResponse.self, from: utf8Data)
                    self.onFactsLoading?(response)
                } catch {
                    self.onError?(error.localizedDescription)
                }
            case .failure(let error):
                self.onError?(error.localizedDescription)
            }
        }
    
    }
}
