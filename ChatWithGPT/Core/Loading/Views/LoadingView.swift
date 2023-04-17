//
//  LoadingView.swift
//  ChatWithGPT
//
//  Created by Bence Papp on 2023. 04. 17..
//

import SwiftUI

struct LoadingView: View {
    let color: Color = .blue
    let width: CGFloat = 10
    @State private var shouldAnimate = false

    var body: some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: width, height: width)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
            Circle()
                .fill(color)
                .frame(width: width, height: width)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
            Circle()
                .fill(color)
                .frame(width: width, height: width)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
        }
        .onAppear {
            self.shouldAnimate = true
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
