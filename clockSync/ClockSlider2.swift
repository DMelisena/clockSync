//
//  ClockSlider2.swift
//  clockSync
//
//  Created by Arya Hanif on 21/04/25.
//

import SwiftUI

enum dragged {
    case start, end, none
}

struct ClockSlider2: View {
    //@state to declare a mutable value that affects visual
    @State private var startAngle: CGFloat = -CGFloat.pi*3.5/6
    @State private var endAngle: CGFloat = CGFloat.pi*5/6
    //no know is being dragged as default state
    @State private var draggedKnob: dragged = .none
    
    let knobDiameter: CGFloat = 60
    let circleDiameter: CGFloat = 230
    let lineWidth: CGFloat = 20
    let min5Snap: CGFloat = 144
    
//    func radToMinutes(hour:CGFloat, minutes: CGFloat) -> Int{
//        return
//    }
    func radToMinutes(deg: CGFloat) -> Int{
        return Int(deg*60*6/CGFloat.pi)
    }
    
    func radToTime(deg: CGFloat) -> (hour:Int, minutes:Int){
        let degMinutes: Int =  Int(deg*60*6/CGFloat.pi)
        let hour: Int = degMinutes/60
        let minutes: Int = degMinutes%60
        return (hour, minutes)
    }
    
    var durationMinutes: Int {
        var radDiff: CGFloat = endAngle - startAngle
        if radDiff < 0 {
            radDiff += 2*CGFloat.pi
        }
        return Int(round(60*12*(radDiff/(CGFloat.pi*2))))
    }
    
    var durationMinutesNegative: Int {
        var radDiff: CGFloat = startAngle - endAngle
        if radDiff < 0 {
            radDiff += 2*CGFloat.pi
        }
        return Int(round(60*12*(radDiff/(CGFloat.pi*2))))
    }
    
    func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
        let xDist = point2.x - point1.x
        let yDist = point2.y - point1.y
        return sqrt(xDist * xDist + yDist * yDist)
    }
        
    

    var body: some View {
        Text("Start Rad :\(startAngle)")
        Text("End Rad :\(endAngle)")
        Text("minutes \(radToMinutes(deg: startAngle))")
        Text("minutes \(radToMinutes(deg: endAngle))")
        Text("Hour : \(radToTime(deg: startAngle ))")
        Text("Hour : \(radToTime(deg: endAngle ))")
        Text("Sleep Time : \(durationMinutes)")
        ZStack{
            Circle()// Background circle
                .stroke(Color(red: 123/255, green: 60/255, blue: 146/255).opacity(0.5), lineWidth: lineWidth * 3)
                .frame(width: circleDiameter, height: circleDiameter)
            
            Canvas { context, size in //Inbetween Sleep
                let center = CGPoint(x: size.width / 2, y: size.height / 2)
                let radius = circleDiameter / 2
                var path = Path()
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: Angle(radians: Double(startAngle)),
                    endAngle: Angle(radians: Double(endAngle)),
                    clockwise: false
                )
                context.stroke(path, with: .color(.purple), lineWidth: lineWidth * 2.5)
            }
            handleView(angle: startAngle)
                .foregroundColor(.cyan)
//                    .offset(x: (sliderDiameter / 2) * cos(startAngle), y: (sliderDiameter / 2) * sin(startAngle))
                .offset(x: (circleDiameter / 2) * cos(startAngle), y: (circleDiameter / 2) * sin(startAngle))

            // End handle
            handleView(angle: endAngle)
                .foregroundColor(.cyan)
                .offset(x: (circleDiameter / 2) * cos(endAngle), y: (circleDiameter / 2) * sin(endAngle))
        }
        .rotationEffect(.degrees(-90)) // Moves 0° to the top
        .gesture(DragGesture()
            .onChanged { value in
                self.handleDrag(value: value.location) //the pressed white handle location
            }
            .onEnded { _ in
                self.draggedKnob = .none //change the handledrag to none when it stopped being pressed
            })
    }
    
    func pointFromAngle(_ angle: CGFloat) -> CGPoint {
        let center = CGPoint(x: self.circleDiameter / 2, y: self.circleDiameter / 2)
        return CGPoint(
            x: center.x + (circleDiameter / 2) * cos(angle),
            y: center.y + (circleDiameter / 2) * sin(angle)
        )
    }
    func angleFromPoint(_ point: CGPoint) -> CGFloat {
        let center = CGPoint(x: self.circleDiameter / 2, y: self.circleDiameter / 2)
        return atan2(point.x-center.x, point.y-center.y)
    }
    private func handleDrag(value: CGPoint) {
        let angle = angleFromPoint(value) //touch radian value of angle from center
        
        // Snapping the angle to hourly intervals (30 degrees)
        let snappedAngle = round(angle / (min5Snap * .pi / 180)) * min5Snap * .pi / 180
        //round the location to the closest 5 min snap point
        
        // Lock the nearest knob
        if draggedKnob == .start { //first pressed rad angle
            startAngle = snappedAngle
        } else if draggedKnob == .end { //handle bar last pressed rad angle
            endAngle = snappedAngle
        }
        
        // Determine which knob to lock, returns point from angle
        let startKnobPoint = pointFromAngle(startAngle)
        let endKnobPoint = pointFromAngle(endAngle)
        // which knob is being pressed based on the distance clicked
        let distanceToStart = distanceBetween(value, startKnobPoint)
        let distanceToEnd = distanceBetween(value, endKnobPoint)
        
        if distanceToStart < distanceToEnd {
            draggedKnob = .start
        } else {
            draggedKnob = .end
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
    ClockSlider2()
        .preferredColorScheme(.dark)
}
