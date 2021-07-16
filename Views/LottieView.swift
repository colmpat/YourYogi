//
//  LottieView.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var name: String
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        let animation = Animation.named(self.name)
        
        animationView.animation = animation
        animationView.loopMode = self.loopMode
        animationView.animationSpeed = 0.5
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        
        return view
    }
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView(name: "loginAnimation")
    }
}
