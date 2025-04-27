//
//  ClockSlider4.swift
//  clockSync
//
//  Created by Arya Hanif on 27/04/25.
//

import SwiftUI

struct ClockSlider4: View {
    @State var startRad: CGFloat = CGFloat.pi * -(3/6)
    @State var endRad: CGFloat = CGFloat.pi * (5/6)
    
    var sliderDiameter: CGFloat = 230
    var barWidth: CGFloat = 70
    var knobDiameter: CGFloat = 75
    var barGap: CGFloat = 10
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .stroke(Color(red: 123/255, green: 60/255, blue: 146/255).opacity(0.5), lineWidth: barWidth)
                    .frame(width: sliderDiameter, height: sliderDiameter)
                Canvas { context, size in
                    let center = CGPoint(x: size.width / 2, y: size.height/2)
                    let radius = sliderDiameter/2
                    var path = Path()
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: Angle(radians: Double(startRad)),
                        endAngle: Angle(radians: Double(endRad)),
                        clockwise: false
                   )
                    context.stroke(path, with: .color(.purple), lineWidth: barWidth-barGap)
                }
                handleView(angle: startRad)
                    .offset(x: (sliderDiameter / 2) * cos(startRad), y: (sliderDiameter / 2) * sin(startRad))
                handleView(angle: endRad)
                    .offset(x: (sliderDiameter / 2) * cos(endRad), y: (sliderDiameter / 2) * sin(endRad))
            }
            .rotationEffect(.degrees(-90)) // Moves 0° to the top
        }
    }
    private func handleView(angle: CGFloat) -> some View {
        Circle()
            .fill(Color.white)
            .frame(width: knobDiameter, height: knobDiameter)
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
    }
}
#Preview {
    ClockTime()
    ClockSlider4()
        .preferredColorScheme(.dark)
}
