import Foundation

@objc public class CapacitorMetaAudience: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
    
}
