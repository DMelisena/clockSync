//
//  ClockSlider.swift
//  clockSync
//
//  Created by Arya Hanif on 15/04/25.
//

import SwiftUI

enum SliderLockType {
    case none, start, end
}

struct ClockSlider: View {
    @State private var startAngle: CGFloat = 0
    @State private var endAngle: CGFloat = 90
    @State private var sliderLock: SliderLockType = .none
    
    // The size of the slider
    private let sliderDiameter: CGFloat = 300
    private let knobDiameter: CGFloat = 20
    private let lineWidth: CGFloat = 4
    private let hourlySnap: CGFloat = 360/144 // Snap to hourly intervals
    
    var durationMinutes: Int {
        let twoPi = CGFloat.pi * 2
        var difference = endAngle - startAngle
        if difference < 0 {
            difference += twoPi
        }
        return Int(60*(difference / (CGFloat.pi / 6))) // π/6 = 30°
//        return Int(twoPi)
    }
    var startAngleDeg: CGFloat {
        startAngle * 180 / .pi
    }
    var endAngleDeg: CGFloat {
        endAngle * 180 / .pi
    }

    var body: some View {
        VStack{
            
//            ZStack {
//                // Draw the circle
//                Circle()
//                    .stroke(Color.gray, lineWidth: lineWidth)
//                    .frame(width: sliderDiameter, height: sliderDiameter)
//                
//                // Draw start angle handle
//                handleView(angle: startAngle)
//                    .foregroundColor(.cyan)
//                    .offset(x: (sliderDiameter / 2) * cos(startAngle), y: (sliderDiameter / 2) * sin(startAngle))
//                
//                // Draw end angle handle
//                handleView(angle: endAngle)
//                    .foregroundColor(.cyan)
//                    .offset(x: (sliderDiameter / 2) * cos(endAngle), y: (sliderDiameter / 2) * sin(endAngle))
//            }
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color.gray, lineWidth: lineWidth)
                    .frame(width: sliderDiameter, height: sliderDiameter)
                
                // Active range arc
                Canvas { context, size in
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    let radius = sliderDiameter / 2

                    var path = Path()
                    path.addArc(
                        center: center,
                        radius: radius,
                        startAngle: Angle(radians: Double(startAngle)),
                        endAngle: Angle(radians: Double(endAngle)),
                        clockwise: false
                    )
                    context.stroke(path, with: .color(.cyan), lineWidth: lineWidth * 2.5)
                }
                .frame(width: sliderDiameter+10, height: sliderDiameter+10)
                
                // Start handle
                handleView(angle: startAngle)
                    .foregroundColor(.cyan)
                    .offset(x: (sliderDiameter / 2) * cos(startAngle), y: (sliderDiameter / 2) * sin(startAngle))
                
                // End handle
                handleView(angle: endAngle)
                    .foregroundColor(.cyan)
                    .offset(x: (sliderDiameter / 2) * cos(endAngle), y: (sliderDiameter / 2) * sin(endAngle))
            }
            .frame(width: sliderDiameter, height: sliderDiameter)
            .gesture(DragGesture()
                        .onChanged { value in
                            self.handleDrag(value: value.location)
                        }
                        .onEnded { _ in
                            self.sliderLock = .none
                        })
            .rotationEffect(.degrees(-90)) // Moves 0° to the top
            Text("Duration: \(durationMinutes/60) hour(s)")
                .font(.headline)
                .padding(.top, 16)
            Text("Duration: \(durationMinutes) minute(s)")
                .font(.headline)
                .padding(.top, 16)
            Text("Start Angle: \(startAngleDeg)")
                .font(.headline)
                .padding(.top, 16)
            Text("End Angle: \(endAngleDeg)")
                .font(.headline)
                .padding(.top, 16)

        }
    }
    
    // Function to create a knob handle based on angle
    private func handleView(angle: CGFloat) -> some View {
        Circle()
            .fill(Color.white)
            .frame(width: knobDiameter, height: knobDiameter)
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
    }
    
    // Helper function to calculate distance between two points
    private func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        let xDist = point2.x - point1.x
        let yDist = point2.y - point1.y
        return sqrt(xDist * xDist + yDist * yDist)
    }
    
    // Function to convert an angle to a point on the circle
    private func pointFromAngle(_ angle: CGFloat) -> CGPoint {
        let center = CGPoint(x: sliderDiameter / 2, y: sliderDiameter / 2)
        return CGPoint(x: center.x + (sliderDiameter / 2) * cos(angle), y: center.y + (sliderDiameter / 2) * sin(angle))
    }
    
    // Function to convert a point into an angle
    private func angleFromPoint(_ point: CGPoint) -> CGFloat {
        let center = CGPoint(x: sliderDiameter / 2, y: sliderDiameter / 2)
        return atan2(point.y - center.y, point.x - center.x)
    }
    
    // Function to handle dragging and updating the knob positions
    private func handleDrag(value: CGPoint) {
        let angle = angleFromPoint(value)
        
        // Snapping the angle to hourly intervals (30 degrees)
        let snappedAngle = round(angle / (hourlySnap * .pi / 180)) * hourlySnap * .pi / 180
        
        // Lock the nearest knob
        if sliderLock == .start {
            startAngle = snappedAngle
        } else if sliderLock == .end {
            endAngle = snappedAngle
        }
        
        // Determine which knob to lock
        let startKnobPoint = pointFromAngle(startAngle)
        let endKnobPoint = pointFromAngle(endAngle)
        
        let distanceToStart = distanceBetween(value, startKnobPoint)
        let distanceToEnd = distanceBetween(value, endKnobPoint)
        
        if distanceToStart < distanceToEnd {
            sliderLock = .start
        } else {
            sliderLock = .end
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("TBCircularSlider")
                .font(.title)
            ClockSlider()
                .padding()
        }
    }
}

struct ClockSlider_Previews: PreviewProvider {
    static var previews: some View {
        ClockSlider()
            .preferredColorScheme(.dark)
    }
}
