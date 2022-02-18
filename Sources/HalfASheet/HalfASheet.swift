//
//  HalfASheet.swift
//
//  Created by Franklyn Weber on 28/01/2021.
//

import SwiftUI

public struct HalfASheet<Content: View>: View {
    @State private var dragOffset: CGFloat = 0
    @State private var contentRect: CGRect = .zero

    internal var backgroundColor: Color
    internal var closeButtonColor: Color
    internal var dimmingBackgoundColor: Color
    internal var height: HalfASheetHeight
    internal var contentInsets: EdgeInsets
    internal var cornerRadius: CGFloat
    internal var allowsDraggingToDismiss: Bool
    internal var allowsButtonDismiss: Bool

    /// NOTE: When allowsDraggingToDismiss is set to true we use this variable to:
    /// 1. Set additional bottom offset to the sheet view to prevent
    ///    view underneath from peaking
    /// 2. Limit up dragging animation to a certain point
    /// NOTE: This parameter limits your "full screen" height, as it shifts
    /// whole view down beneath bottom screen edge.
    internal var maxOffsetForDraggingUp: CGFloat
        
    @Binding private var isPresented: Bool
    private let title: String?
    private let content: () -> Content

    public init(
        isPresented: Binding<Bool>,
        title: String? = nil,
        @ViewBuilder content: @escaping () -> Content,
        configuration: HalfASheetConfiguration? = nil
    ) {
        _isPresented = isPresented
        self.title = title
        self.content = content
        
        self.backgroundColor = configuration?.backgroundColor ?? Color.white
        self.closeButtonColor = configuration?.closeButtonColor ?? Color.gray.opacity(0.4)
        self.dimmingBackgoundColor = configuration?.dimmingBackgoundColor ?? Color.black.opacity(0.25)
        self.height = configuration?.height ?? .proportional(0.84)
        self.contentInsets = configuration?.contentInsets ?? EdgeInsets(top: 7, leading: 16, bottom: 12, trailing: 16)
        self.cornerRadius = configuration?.cornerRadius ?? 15
        self.allowsDraggingToDismiss = configuration?.allowsDraggingToDismiss ?? true
        self.allowsButtonDismiss = configuration?.allowsButtonDismiss ?? true
        self.maxOffsetForDraggingUp = configuration?.maxOffsetForDraggingUp ?? 44
    }
    
    private var actualContentInsets: EdgeInsets {
        return EdgeInsets(
            top: contentInsets.top,
            leading: contentInsets.leading,
            bottom: cornerRadius
                    + maxOffsetForDraggingUp
                    + contentInsets.bottom
                    + UIApplication.shared.safeAreaInsets.bottom,
            trailing: contentInsets.trailing
        )
    }
    
    private func calculateActualFrameHeight(sheetHeight: CGFloat) -> CGFloat {
        return sheetHeight
                + cornerRadius
                + maxOffsetForDraggingUp
                + UIApplication.shared.safeAreaInsets.bottom
    }

    private func calculateActualYOffset() -> CGFloat {
        return cornerRadius
                + maxOffsetForDraggingUp
                + dragOffset
                + UIApplication.shared.safeAreaInsets.bottom
    }

    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isPresented {
                    dimmingBackgoundColor.ignoresSafeArea()
                        .onTapGesture {
                            dismiss()
                        }
                        .transition(.opacity)
                    
                    VStack {
                        Spacer()
                        
                        VStack(spacing: 0) {
                            EitherView(title != nil || allowsButtonDismiss) {
                                titleView
                            }

                            content()
                                .padding(actualContentInsets)
                            
                            if height.value(with: geometry) != nil {
                                Spacer(minLength: 0)
                            }
                        }
                        .if(height.value(with: geometry) != nil) { content in
                            content.frame(height: calculateActualFrameHeight(sheetHeight: height.value(with: geometry)!))
                        }
                        .background(
                            GeometryReader { geoReader in
                                backgroundColor.preference(
                                    key: RectPreferenceKey.self,
                                    value: geoReader.frame(in: .global)
                                )
                                .onPreferenceChange(RectPreferenceKey.self) { newValue in
                                    contentRect = newValue
                                }
                            }
                        )
                        .cornerRadius(cornerRadius)
                        .offset(y: calculateActualYOffset())
                    }
                    .zIndex(1)
                    .transition(.verticalSlide(height.value(with: geometry)))
                    .highPriorityGesture(
                        dragGesture(geometry)
                    )
                    .onDisappear {
                        dragOffset = 0
                    }
                }
            }
        }
        .animation(.default, value: isPresented)
    }
}


// MARK: - Private
extension HalfASheet {
    private var titleView: EitherView {
        EitherView(title) { title in
            HStack(alignment: .center) {
                // NOTE: To properly center Text view
                closeButton
                    .opacity(0)
                    .disabled(true)
                
                Spacer()
                
                Text(title)
                    .font(Font.headline.weight(.semibold))
                    .padding(0.0)
                    .lineLimit(1)
                
                Spacer()
                
                closeButton
            }
        } else: {
            HStack {
                Spacer()
                closeButton
            }
        }
    }
    
    private func dragGesture(_ geometry: GeometryProxy) -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture()
            .onChanged { dragValue in
                guard allowsDraggingToDismiss else {
                    return
                }
                
                let offset = dragValue.translation.height
                dragOffset = offset > 0 ? offset : max(sqrt(-offset) * -3, -maxOffsetForDraggingUp)
            }
            .onEnded { dragValue in
                guard allowsDraggingToDismiss else {
                    return
                }
                
                // Dismissing "by velocity"
                if dragOffset > 0, dragValue.predictedEndTranslation.height / dragValue.translation.height > 2 {
                    dismiss()
                    return
                }
                
                // Dismissing "by distance"
                let validDragDistance = (contentRect.height - maxOffsetForDraggingUp) / 2
                if dragOffset >= validDragDistance {
                    dismiss()
                    return
                }
                
                withAnimation {
                    dragOffset = 0
                }
            }
    }
    
    private var closeButton: AnyView {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(Font.title.weight(.semibold))
                .accentColor(closeButtonColor)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 13))
        }.toAnyView()
    }
    
    private func dismiss() {
        isPresented = false
    }
}
