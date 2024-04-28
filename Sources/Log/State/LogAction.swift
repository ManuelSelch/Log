import Foundation

@available(iOS 16.0, *)
public enum LogAction {
    case error(_ error: String?)
    case message(_ message: String?)
}
