//
//  LottieView.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var animationName: String
    let loopMode: LottieLoopMode

    func updateUIView(_ uiView: UIViewType, context: Context) {

    }

    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.play()
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleToFill
        return animationView
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(animationName: "plane", loopMode: .loop)
    }
}
