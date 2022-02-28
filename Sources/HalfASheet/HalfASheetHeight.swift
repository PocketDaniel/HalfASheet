//
//  HalfASheetHeight.swift
//
//  Created by Daniel Klinge on 17/02/2022.
//

import SwiftUI

public enum HalfASheetHeight {
    case fixed(CGFloat)
    case proportional(CGFloat)
    case minimal

    func value(with geometry: GeometryProxy) -> CGFloat? {
        switch self {
        case .fixed(let height):
            return height
        case .proportional(let proportion):
            return geometry.size.height * proportion
        case .minimal:
            return nil
        }
    }
}
