//
//  Spacer.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import Foundation
import SwiftUI

struct VSpacer: View {
    
    init(_ height: CGFloat) {
        self.height = height
    }
    
    public var height: CGFloat
    
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}

struct HSpacer: View {
    
    init(_ width: CGFloat) {
        self.width = width
    }
    
    public var width: CGFloat
    
    var body: some View {
        Spacer()
            .frame(width: width)
    }
}
