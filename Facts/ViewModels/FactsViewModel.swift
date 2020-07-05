

import Foundation
import Moya

class FactsViewModel {
    
    private let provider = MoyaProvider<FactType>()
    var onError: ((String) -> Void)?
    var onFactsLoading: ((FactsResponse) -> Void)?
    
    func getFacts(_ completion: ((Result<FactsResponse, Error>) -> Void)? = nil) {
        provider.request(.getFacts) { (result) in
            switch result {
            case .success(let value):
                do {
                    guard let utf8Data = String(decoding: value.data, as: UTF8.self).data(using: .utf8) else {
                        self.onError?("Something went wrong. Please try again.")
                        return
                    }
                    let response = try JSONDecoder().decode(FactsResponse.self, from:utf8Data)
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
