import Foundation
import Combine
import os
import Redux

@available(iOS 16.0, *)
public class LogMiddleware<AppAction> {
    let logger: Logger = Logger(subsystem: "de.selch.refactor", category: "refactor log")
    
    public init(){}
    
    public func log(_ message: String){
        logger.log("\(message, privacy: .public)")
    }
    
    public static func formatAction(_ action: AppAction) -> String {
        let actionStr = "\(action)"
        print(actionStr)
        let methods = actionStr.split(separator: "(")
        var methodsFormatted: [String] = []
        for method in methods {
            if(
                method.contains(":") ||
                method.contains("\"") ||
                method.contains("-") ||
                method.contains("[") ||
                method.contains("]")
            ){
                continue // only show action but no data
            }
            
            if let methodFormatted = method.split(separator: ".").last {
                let strMethodFormatted = String(methodFormatted).replacing(")",with: "")
                if(
                    strMethodFormatted.split(separator: " ").count == 1
                ){
                    methodsFormatted.append(strMethodFormatted)
                }
            }
        
        }
        
        var actionFormatted = ""
        for method in methodsFormatted {
            actionFormatted += "." + method
        }
        
        return actionFormatted
    }
    
    public func handle(_ state: LogFeature.State, _ action: AppAction) -> AnyPublisher<LogFeature.Action, Never> {
        if(!state.isLog){
            return Empty().eraseToAnyPublisher()
        }
        
        let actionFormatted = Self.formatAction(action)
        log(actionFormatted)
        return Just(.message(actionFormatted)).eraseToAnyPublisher()
    }
    
    // MARK: - private functions
    public func handleError(_ error: Error) -> AnyPublisher<LogFeature.Action, Error>  {
        return .send(.error("\(error)"))
    }
}


