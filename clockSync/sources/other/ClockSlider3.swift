//
//  ClockSlider3.swift
//  clockSync
//
//  Created by Arya Hanif on 27/04/25.
//

import SwiftUI

struct ClockSlider3: View {
    
    let lineWidth: CGFloat = 10
    let sliderDiameter: CGFloat = 230
    
    
    var body: some View {
        VStack{
            VStack{
                //                Circle()
                //                    .stroke(Color(red: 123/255, green: 60/255, blue: 146/255).opacity(0.5), lineWidth: lineWidth * 3)
                //                    .frame(width: sliderDiameter, height: sliderDiameter)
                //                Canvas { context, size in
                //                }
                //                .frame(width: sliderDiameter, height: sliderDiameter)
                //                .border(Color.yellow, width: 4)
                Canvas { context, size in
                    var path = Path()
                    path.move(to: CGPoint(x: size.width/2, y: 0))
                    path.addLine(to: CGPoint(x: 0 , y: size.height))
                    path.addLine(to: CGPoint(x: size.width, y: size.height))
                    path.addLine(to: CGPoint(x: size.width/2, y: 0))
                    //                    context.stroke(path, with: .color(.red), lineWidth: 2)
                    context.stroke(path, with: .color(.red), lineWidth: 5)
                }
                Canvas { context, size in
                    var path = Path()
                    path.move(to: CGPoint(x: size.width/2, y: size.height/2))
                    path.addLine(to: CGPoint(x: 0, y: 0))
                    //                    context.stroke(path, with: .color(.red), lineWidth: 2)
                    context.stroke(path, with: .color(.blue), lineWidth: 5)
                }
                
//                TimelineView(.animation) { timelineContext in
//                    let value = secondsValue(for: timelineContext.date)
//                    Canvas(
//                        opaque: true,
//                        colorMode: .linear,
//                        rendersAsynchronously: false) { context, size in
//                        let newSize = size.applying(.init(scaleX: value, y: 1))
//                        let rect = CGRect(origin: .zero, size: newSize)
//                        
//                        context.fill(
//                            Rectangle().path(in: rect),
//                            with: .color(.red)
//                        )
//                        }
//                }
            }
        }
    }
    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        return Double(seconds) / 600
    }
}

#Preview {
    ClockSlider3()
}
