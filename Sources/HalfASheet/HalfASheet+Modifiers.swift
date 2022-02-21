//
//  HalfASheet+Modifiers.swift
//
//  Created by Franklyn Weber on 04/02/2021.
//

import SwiftUI


extension HalfASheet {
    
    /// The animation duration for appearance of HalfASheet
    /// - Parameter appearanceAnimationDuration: a Double
    public func appearanceAnimationDuration(_ appearanceAnimationDuration: Double) -> Self {
        var copy = self
        copy.appearanceAnimationDuration = appearanceAnimationDuration
        return copy
    }

    /// The background colour for the HalfASheet
    /// - Parameter backgroundColor: a Color
    public func backgroundColor(_ backgroundColor: Color) -> Self {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }

    /// The color for the close button
    /// - Parameter closeButtonColor: a Color
    public func closeButtonColor(_ closeButtonColor: Color) -> Self {
        var copy = self
        copy.closeButtonColor = closeButtonColor
        return copy
    }

    /// The color for the dimming background view
    /// - Parameter dimmingBackgoundColor: a Color
    public func dimmingBackgoundColor(_ dimmingBackgoundColor: Color) -> Self {
        var copy = self
        copy.dimmingBackgoundColor = dimmingBackgoundColor
        return copy
    }

    /// The proportion of the containing view's height to use for the height of the HalfASheet
    /// - Parameter height: a HalfASheetHeight case
    public func height(_ height: HalfASheetHeight) -> Self {
        var copy = self
        copy.height = height
        return copy
    }

    /// Insets to use around the content of the HalfASheet
    /// - Parameter contentInsets: an EdgeInsets instance
    public func contentInsets(_ contentInsets: EdgeInsets) -> Self {
        var copy = self
        copy.contentInsets = contentInsets
        return copy
    }

    /// Corner radious for HalfASheet
    /// - Parameter cornerRadius: a CGFloat 
    public func cornerRadius(_ cornerRadius: CGFloat) -> Self {
        var copy = self
        copy.cornerRadius = cornerRadius
        return copy
    }

    /// Use this to disable the drag-downwards-to-dismiss functionality
    public var disableDragToDismiss: Self {
        var copy = self
        copy.allowsDraggingToDismiss = false
        return copy
    }

    /// Use this to disable the button-to-dismiss functionality
    public var disableButtonToDismiss: Self {
        var copy = self
        copy.allowsButtonDismiss = false
        return copy
    }
    
    /// Changes maximum allowed offset for upwards-drag animation / gesture
    /// - Parameter maxOffsetForDraggingUp: a CGFloat
    public func maxOffsetForDraggingUp(_ maxOffsetForDraggingUp: CGFloat) -> Self {
        var copy = self
        copy.maxOffsetForDraggingUp = maxOffsetForDraggingUp
        return copy
    }
}


extension View {
    
    /// View extension in the style of .sheet - offers no real customisation. If more flexibility is required, use HalfASheet(...) directly, and apply the required modifiers
    /// - Parameters:
    ///   - isPresented: binding to a Bool which controls whether or not to show the partial sheet
    ///   - title: an optional title for the sheet
    ///   - content: the sheet's content
    ///   - configuration: an optional configuration override for HalfASheet view
    public func halfASheet<T: View>(
        isPresented: Binding<Bool>,
        title: String? = nil,
        @ViewBuilder content: @escaping () -> T,
        configuration: HalfASheetConfiguration?
    ) -> some View {
        modifier(HalfASheetPresentationModifier(
            content: {
                HalfASheet(
                    isPresented: isPresented,
                    title: title,
                    content: content,
                    configuration: configuration
                )
            }
        ))
    }
}

struct HalfASheetPresentationModifier<SheetContent>: ViewModifier where SheetContent: View {
    
    var content: () -> HalfASheet<SheetContent>
    
    init(@ViewBuilder content: @escaping () -> HalfASheet<SheetContent>) {
        self.content = content
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            self.content()
        }
    }
}
