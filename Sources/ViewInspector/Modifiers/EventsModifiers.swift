// MARK: - ViewEvents

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
public extension InspectableView {
    
    func callOnAppear() throws {
        let callback = try modifierAttribute(
            modifierName: "_AppearanceActionModifier", path: "modifier|appear",
            type: (() -> Void).self, call: "onAppear")
        callback()
    }
    
    func callOnDisappear() throws {
        let callback = try modifierAttribute(
            modifierName: "_AppearanceActionModifier", path: "modifier|disappear",
            type: (() -> Void).self, call: "onDisappear")
        callback()
    }

    func callOnChange<E: Equatable>(newValue value: E, index: Int = 0) throws {
        let typeName = Inspector.typeName(type: E.self)
        if let callback = try? modifierAttribute(
            modifierName: "_ValueActionModifier<\(typeName)>",
            path: "modifier|action",
            type: ((E) -> Void).self,
            call: "onChange", index: index) {
            callback(value)
            return
        }
        let callback = try modifierAttribute(
            modifierName: "_ValueActionModifier<Optional<\(typeName)>>",
            path: "modifier|action",
            type: ((E?) -> Void).self,
            call: "onChange", index: index)
        callback(value)
    }
}
