//
//  circle on click.swift
//  clockSync
//
//  Created by Arya Hanif on 30/04/25.
//
import SwiftUI

enum beingdragged {
    case none, circle, rectangular, square, triangle, pentagon
}

struct circle_on_click: View {
    @State private var circlePosition: CGPoint? = nil
    func distanceBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x
        let dy = point1.y - point2.y
        return sqrt(dx * dx + dy * dy)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white
                    .ignoresSafeArea()
                    .gesture(
                        DragGesture(minimumDistance: 5)
                            .onEnded { value in
                                circlePosition = value.location
                                print("Clicked at: \(value.location)")
                            }
                    )

                if let position = circlePosition {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 50, height: 50)
                        .position(position)
                }
            }
        }
    }
}


#Preview {
    circle_on_click()
}
