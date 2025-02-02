//
//  HalfASheetConfiguration.swift
//
//  Created by Daniel Klinge on 18/02/2022.
//

import SwiftUI

public struct HalfASheetConfiguration {
    public var appearanceAnimationDuration: Double?
    public var backgroundColor: Color?
    public var dimmingBackgoundColor: Color?
    public var height: HalfASheetHeight?
    public var contentInsets: EdgeInsets?
    public var cornerRadius: CGFloat?
    public var allowsDraggingToDismiss: Bool?
    public var maxOffsetForDraggingUp: CGFloat?
    
    public init(
        appearanceAnimationDuration: Double? = nil,
        backgroundColor: Color? = nil,
        dimmingBackgoundColor: Color? = nil,
        height: HalfASheetHeight? = nil,
        contentInsets: EdgeInsets? = nil,
        cornerRadius: CGFloat? = nil,
        allowsDraggingToDismiss: Bool? = nil,
        maxOffsetForDraggingUp: CGFloat? = nil
    ) {
        self.appearanceAnimationDuration = appearanceAnimationDuration
        self.backgroundColor = backgroundColor
        self.dimmingBackgoundColor = dimmingBackgoundColor
        self.height = height
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
        self.allowsDraggingToDismiss = allowsDraggingToDismiss
        self.maxOffsetForDraggingUp = maxOffsetForDraggingUp
    }
}
