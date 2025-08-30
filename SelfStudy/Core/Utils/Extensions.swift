//
//  Extensions.swift
//  SelfStudy
//
//  Created by simon on 30/08/2025.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // skip #
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}
