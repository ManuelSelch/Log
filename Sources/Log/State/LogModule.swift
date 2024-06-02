import Foundation
import Combine
import Redux

public struct LogModule: Reducer  {
    public init() {}
    
    public struct State: Equatable, Codable {
        var error: String?
        var message: String?
        public var isLog: Bool = false
        
        public init(){}
    }
    
    public enum Action: Codable {
        case error(_ error: String?)
        case message(_ message: String?)
        case setLog(Bool)
    }

    public func reduce(_ state: inout State, _ action: Action) -> AnyPublisher<Action, Error> {
        
        switch action {
        case .error(let error):
            state.error = error
        case .message(let message):
            state.message = message
        case .setLog(let isLog):
            state.isLog = isLog
        }
        
        
        return Empty().eraseToAnyPublisher()
    }
    

}
