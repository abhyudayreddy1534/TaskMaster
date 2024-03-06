//
//  HideKeyboardExtention.swift
//  TaskMaster
//
//  Created by Sravanthi Chinthireddy on 05/03/24.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
#endif
