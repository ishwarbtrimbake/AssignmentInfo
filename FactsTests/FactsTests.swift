import XCTest
import Moya

@testable import Facts

class FactsTests: XCTestCase {

    override func setUp() {
    
    }

    override func tearDown() {
        
    }

    func testFactsLoading() {
        MoyaProvider<FactType>().request(.getFacts) { (result) in
            switch result {
            case .success(let value):
                do {
                    guard let utf8Data = String(decoding: value.data, as: UTF8.self).data(using: .utf8) else {
                        XCTFail("Data is not in correct format.")
                        return
                    }
                    let response = try JSONDecoder().decode(FactsResponse.self, from: utf8Data)
                    XCTAssert(response.title != nil, "title must be not-nil")
                    XCTAssert(response.rows != nil, "rows must not be nil")
                    XCTAssert(response.rows?.count == 0, "rows must have values")
                } catch {
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }
}

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
    
    var method: Moya.Method {
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
