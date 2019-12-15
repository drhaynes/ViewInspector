import SwiftUI

// MARK: - Padding

public extension InspectableView {
    
    func padding() throws -> EdgeInsets {
        return try modifierAttribute(
            modifierName: "_PaddingLayout", path: "modifier|insets",
            type: EdgeInsets.self, call: "padding")
    }
}