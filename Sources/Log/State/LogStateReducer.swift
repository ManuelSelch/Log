import Foundation
import Combine

@available(iOS 16.0, *)
public struct LogDependency {
    public init(){}
}

@available(iOS 16.0, *)
public extension LogState {
    static func reduce(_ state: inout LogState, _ action: LogAction, _ env: LogDependency) -> AnyPublisher<LogAction, Error> {
        
        switch action {
        case .error(let error):
            state.error = error
        case .message(let message):
            state.message = message
            break
        }
        
        
        return Empty().eraseToAnyPublisher()
    }
}
