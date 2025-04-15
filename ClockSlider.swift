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
    @State private var endAngle: CGFloat = 270
    @State private var sliderLock: SliderLockType = .none
    
    // The size of the slider
    private let sliderDiameter: CGFloat = 300
    private let knobDiameter: CGFloat = 20
    private let lineWidth: CGFloat = 4
    private let hourlySnap: CGFloat = 30 // Snap to hourly intervals
    
    var body: some View {
        ZStack {
            // Draw the circle
            Circle()
                .stroke(Color.gray, lineWidth: lineWidth)
                .frame(width: sliderDiameter, height: sliderDiameter)
            
            // Draw start angle handle
            handleView(angle: startAngle)
                .foregroundColor(.cyan)
                .offset(x: (sliderDiameter / 2) * cos(startAngle), y: (sliderDiameter / 2) * sin(startAngle))
            
            // Draw end angle handle
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
