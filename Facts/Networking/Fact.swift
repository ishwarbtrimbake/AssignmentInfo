import Moya

///This is network abstraction layer for getting facts.
///This has been implemented with Moya cocoapod and which works on the top of Alamofire.
enum FactType {
    case getFacts
}

extension FactType: TargetType {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }
    
    var path: String {
        return "facts.json"
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getFacts:
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
