//
//  UIApplication+Extensions.swift
//
//  Created by Daniel Klinge on 17/02/2022.
//

import SwiftUI

extension UIApplication {
    var keyWindow: UIWindow? {
        connectedScenes
            .compactMap {  scene in
                scene as? UIWindowScene
            }
            .flatMap {  scene in
                scene.windows
            }
            .first {  scene in
                scene.isKeyWindow
            }
    }
    
    var safeAreaInsets: EdgeInsets {
        self.keyWindow?.safeAreaInsets.swiftUiInsets ?? EdgeInsets()
    }
}
