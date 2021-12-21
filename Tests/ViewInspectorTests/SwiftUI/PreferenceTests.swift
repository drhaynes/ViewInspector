import XCTest
import SwiftUI
@testable import ViewInspector

@available(iOS 13.0, macOS 10.15, tvOS 13.0, *)
final class PreferenceTests: XCTestCase {
    
    func testPreference() throws {
        let sut = EmptyView().preference(key: Key.self, value: "test")
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTransformPreference() throws {
        let sut = EmptyView().transformPreference(Key.self) { _ in }
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testAnchorPreference() throws {
        let source = Anchor.Source([Anchor<String>.Source]())
        let sut = EmptyView().anchorPreference(key: Key.self, value: source, transform: { _ in "" })
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testTransformAnchorPreference() throws {
        let source = Anchor.Source([Anchor<String>.Source]())
        let sut = EmptyView().transformAnchorPreference(key: Key.self, value: source, transform: { _, _ in })
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testOnPreferenceChange() throws {
        let sut = EmptyView().onPreferenceChange(Key.self) { _ in }
        XCTAssertNoThrow(try sut.inspect().emptyView())
    }
    
    func testOverlayPreferenceValue() throws {
        let sut = try EmptyView()
            .overlayPreferenceValue(Key.self) { _ in Text("Test") }
            .inspect()
        XCTAssertNoThrow(try sut.emptyView())
        XCTAssertEqual(try sut.overlayPreferenceValue().text().string(), "Test")
    }
    
    func testBackgroundPreferenceValue() throws {
        let sut = try EmptyView()
            .backgroundPreferenceValue(Key.self) { _ in Text("Test") }
            .inspect()
        XCTAssertNoThrow(try sut.emptyView())
        XCTAssertEqual(try sut.backgroundPreferenceValue().text().string(), "Test")
    }
    
    func testRetainsModifiers() throws {
        let view = Text("Test")
            .padding()
            .overlayPreferenceValue(Key.self) { _ in EmptyView().padding() }
            .padding().padding()
        let sut1 = try view.inspect().text()
        XCTAssertEqual(sut1.content.medium.viewModifiers.count, 4)
        let sut2 = try view.inspect().overlayPreferenceValue().emptyView()
        XCTAssertEqual(sut2.content.medium.viewModifiers.count, 1)
    }
    
    struct Key: PreferenceKey {
        static var defaultValue: String = "abc"
        static func reduce(value: inout String, nextValue: () -> String) {
            value = nextValue()
        }
    }
}
