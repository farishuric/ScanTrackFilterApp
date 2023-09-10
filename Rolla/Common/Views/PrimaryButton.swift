//
//  PrimaryButton.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI

struct PrimaryButton: View {
    var buttonLabel: String
    let color: Color
    var action: () -> Void
    var foregroundColor: Color = .white

    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Text(buttonLabel)
                    .font(.system(size: 14))
                    .foregroundColor(foregroundColor)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(100)
            
        }

    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(buttonLabel: "Test", color: .purple, action: {print("Tap")})
    }
}
