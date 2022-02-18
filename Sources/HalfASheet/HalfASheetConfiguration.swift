//
//  HalfASheetConfiguration.swift
//
//  Created by Daniel Klinge on 18/02/2022.
//

import SwiftUI

public struct HalfASheetConfiguration {
    public var backgroundColor: Color?
    public var closeButtonColor: Color?
    public var dimmingBackgoundColor: Color?
    public var height: HalfASheetHeight?
    public var contentInsets: EdgeInsets?
    public var cornerRadius: CGFloat?
    public var allowsDraggingToDismiss: Bool?
    public var allowsButtonDismiss: Bool?
    public var maxOffsetForDraggingUp: CGFloat?
    
    public init(
        backgroundColor: Color? = nil,
        closeButtonColor: Color? = nil,
        dimmingBackgoundColor: Color? = nil,
        height: HalfASheetHeight? = nil,
        contentInsets: EdgeInsets? = nil,
        cornerRadius: CGFloat? = nil,
        allowsDraggingToDismiss: Bool? = nil,
        allowsButtonDismiss: Bool? = nil,
        maxOffsetForDraggingUp: CGFloat? = nil
    ) {
        self.backgroundColor = backgroundColor
        self.closeButtonColor = closeButtonColor
        self.dimmingBackgoundColor = dimmingBackgoundColor
        self.height = height
        self.contentInsets = contentInsets
        self.cornerRadius = cornerRadius
        self.allowsDraggingToDismiss = allowsDraggingToDismiss
        self.allowsButtonDismiss = allowsButtonDismiss
        self.maxOffsetForDraggingUp = maxOffsetForDraggingUp
    }
}
