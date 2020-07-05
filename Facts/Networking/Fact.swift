
import Moya

enum FactType {
    case getFacts
}

extension FactType: TargetType {
    var baseURL: URL {
        return URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/")!
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
    
    var headers: [String : String]? {
        return nil
    }
}
