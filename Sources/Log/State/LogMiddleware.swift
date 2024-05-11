import Foundation
import Combine
import os
import Redux

@available(iOS 16.0, *)
public class LogMiddleware<AppAction>: IService {
    let logger: Logger = Logger(subsystem: "de.selch.refactor", category: "refactor log")
    
    public init(){}
    
    public func log(_ message: String){
        logger.log("\(message, privacy: .public)")
    }
    
    public func handle(_ state: LogState, _ action: AppAction) -> AnyPublisher<LogAction, Never> {
        if(!state.isLog){
            return Empty().eraseToAnyPublisher()
        }
        
        let actionStr = "\(action)"
                
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
        
        log(actionFormatted)
        
        return Just(.message(actionFormatted)).eraseToAnyPublisher()
    }
    
    // MARK: - private functions
    public func handleError(_ error: Error) -> AnyPublisher<LogAction, Error>  {
        return just(.error("\(error)"))
    }
}


