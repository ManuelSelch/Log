import SwiftUI
import Redux

@available(iOS 16.0, *)
public struct LogContainer: View {
    @ObservedObject var store: StoreOf<LogFeature>
    
    public init(store: StoreOf<LogFeature>) {
        self.store = store
    }
    
    public var body: some View {
        HStack {
            Spacer()
            VStack {
                if let error = self.store.state.error {
                    Button(action: {
                        self.store.send(.error(nil))
                    }){
                        Text(error)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                }
                
                if let message = store.state.message {
                    Button(action: {
                        store.send(.message(nil))
                    }){
                        Text(message)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                    }
                }
            }
            Spacer()
        }
    }
}
