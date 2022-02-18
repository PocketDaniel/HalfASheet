//
//  RectPreferences.swift
//
//  Created by Daniel Klinge on 17/02/2022.
//

import SwiftUI

/// This PeferenceKey is used to pass a CGRect value from the child view to the parent view.
struct RectPreferenceKey: PreferenceKey
{
    typealias Value = CGRect

    static var defaultValue = CGRect.zero

    static func reduce(value: inout CGRect, nextValue: () -> CGRect)
    {
        value = nextValue()
    }
}
