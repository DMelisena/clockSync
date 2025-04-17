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
    @State private var startAngle: CGFloat = -1.57
    @State private var endAngle: CGFloat = 2.62
    @State private var sliderLock: SliderLockType = .none
    
    // The size of the slider
    private let sliderDiameter: CGFloat = 230
    private let knobDiameter: CGFloat = 75
    private let lineWidth: CGFloat = 20
    private let hourlySnap: CGFloat = 360/144 // Snap to hourly intervals
    
    var sliderDiameterAddWidth: CGFloat {
        sliderDiameter + (lineWidth*3)
        //FINE TUNE when changing sliderDiameter/lineWidth
    }
    var durationMinutes: Int {
        let twoPi = CGFloat.pi * 2
        var difference = endAngle - startAngle
        if difference < 0 {
            difference += twoPi
        }
        return Int(60*(difference / (CGFloat.pi / 6))) // π/6 = 30°
    }
    var startAngleDeg: CGFloat {
        startAngle * 180 / .pi
    }
    var endAngleDeg: CGFloat {
        endAngle * 180 / .pi
    }
    func timeFromAngle(_ angle: CGFloat) -> (hour: Int, minute: Int) {
        let twoPi = CGFloat.pi * 2
        var normalized = angle.truncatingRemainder(dividingBy: twoPi)
        if normalized < 0 { normalized += twoPi }
        
        // Convert angle to total minutes (12 hours = 720 minutes = 2π radians)
        let totalMinutes = normalized / twoPi * 720
        let hour = Int(totalMinutes) / 60
        let minute = Int(totalMinutes) % 60
        
        return (hour, minute)
    }
    var formattedDuration: String {
        let hours = durationMinutes / 60
        let minutes = durationMinutes % 60
        
        if hours > 0 && minutes > 0 {
            return "\(hours) hour\(hours != 1 ? "s" : "") and \(minutes) minute\(minutes != 1 ? "s" : "") of sleep"
        } else if hours > 0 {
            return "\(hours) hour\(hours != 1 ? "s" : "") of sleep"
        } else {
            return "\(minutes) minute\(minutes != 1 ? "s" : "") of sleep"
        }
    }
    var body: some View {
        VStack{
            let startTime = timeFromAngle(startAngle)
            let endTime = timeFromAngle(endAngle)
            Text("\(startTime.hour):\(String(format: "%02d", startTime.minute)) - \(endTime.hour):\(String(format: "%02d", endTime.minute))")
                .font(.system(size: 38, weight: .bold, design: .default))
            
            .padding(20) // Adds 20 points
            ZStack {
                // Background circle
                Circle()
                    .stroke(Color(red: 123/255, green: 60/255, blue: 146/255).opacity(0.5), lineWidth: lineWidth * 3)
                
                    .frame(width: sliderDiameter, height: sliderDiameter)
                
                // Clock's strips
                Canvas { context, size in
                    let center = CGPoint(x: size.width / 2, y: size.height / 2)
                    let radius = sliderDiameter / 3 + 4
                    let tickLength: CGFloat = 8
                    let tickWidth: CGFloat = 2
                    
                    for i in 0..<12 {
                        let angle = CGFloat(i) * .pi / 6 // 30° per hour
                        let tickStart = CGPoint(
                            x: center.x + (radius - tickLength) * cos(angle),
                            y: center.y + (radius - tickLength) * sin(angle)
                        )
                        let tickEnd = CGPoint(
                            x: center.x + radius * cos(angle),
                            y: center.y + radius * sin(angle)
                        )
                        
                        var path = Path()
                        path.move(to: tickStart)
                        path.addLine(to: tickEnd)
                        context.stroke(path, with: .color(Color.white.opacity(0.5)), lineWidth: tickWidth)
                    }
                }
                .frame(width: sliderDiameter, height: sliderDiameter)
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
                    context.stroke(path, with: .color(.purple), lineWidth: lineWidth * 2.5)
//                    context.stroke(path, with: .color(Color(red: 123/255, green: 60/255, blue: 146/255)), lineWidth: lineWidth * 2.5)
                }
                .frame(width: sliderDiameterAddWidth, height: sliderDiameterAddWidth)
                
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
            .padding(20) // Adds 20 points
            //            Text("Duration: \(durationMinutes/60) hour(s)")
            //                .font(.headline)
            //                .padding(.top, 16)
            //            Text("Duration: \(durationMinutes) minute(s)")
            //                .font(.headline)
            //                .padding(.top, 16)
            //            Text("Start Angle: \(startAngleDeg)")
            //                .font(.headline)
            //                .padding(.top, 16)
            //            Text("End Angle: \(endAngleDeg)")
            //                .font(.headline)
            //                .padding(.top, 16)
            Text(formattedDuration)
                .font(.headline)
                .padding(.top, 20)
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
