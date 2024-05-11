import Foundation
import Combine


@available(iOS 16.0, *)
public struct LogState: Equatable {
    var error: String?
    var message: String?
    public var isLog: Bool = false
    
    public init(){}
}
