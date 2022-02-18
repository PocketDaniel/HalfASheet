//
//  View+Extensions.swift
//
//  Created by Daniel Klinge on 17/02/2022.
//

import SwiftUI

extension View {
    /// If you want to conditionally embed view in another view:
    /// var body: some View {
    ///     VStack() {
    ///         Text("Line 1")
    ///         Text("Line 2")
    ///     }
    ///     .if(someCondition) { content in
    ///         ScrollView(.vertical) { content }
    ///     }
    /// }
    ///
    /// Also you can use it to conditionally apply modifiers to a view:
    /// var body: some View {
    ///     Text("Some text")
    ///     .if(someCondition) { content in
    ///         content.foregroundColor(.red)
    ///     }
    /// }
    @ViewBuilder
    public func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }

    public func toAnyView() -> AnyView {
        return AnyView(self)
    }
}
