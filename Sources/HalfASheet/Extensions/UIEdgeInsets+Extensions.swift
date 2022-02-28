//
//  UIEdgeInsets+Extensions.swift
//
//  Created by Daniel Klinge on 17/02/2022.
//

import SwiftUI

extension UIEdgeInsets {
    var swiftUiInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
