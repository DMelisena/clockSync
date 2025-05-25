//
//  Responsive.swift
//  clockSync
//
//  Created by Arya Hanif on 30/04/25.

import SwiftUI

enum SliderLockTypeNew { // Which slider is being moved. so if start is clicked, it would be the only deg value that could be changed
    case none, start, end
}

//struct Responsive: View {
//    @State var clockSlider4 = ClockSlider4()
//    init() {
//        _clockSlider4 = State(initialValue: ClockSlider4(
//            startRad: hourToRad(-3.5),
//            endRad: hourToRad(5)))
//    }
//    
//    @State private var circlePosition: CGPoint? = nil
//    @State var startRad: CGFloat = ClockSlider4().startRad
//    @State var endRad: CGFloat = ClockSlider4().endRad
//    @State var sliderDiameter: CGFloat = ClockSlider4().endRad
//    @State private var sliderLock: SliderLockTypeNew = .none
//    
//    let min5Snap: CGFloat = 360 / 12 / 12 // Snap to 5 minutes interval (12 hours and 60mins/5)
////    var sliderDiameter: CGFloat {
////        return clockSlider4.sliderDiameter
////    }
//
//    func anglefromPoint(_ point: CGPoint) -> Double {
//        let center = CGPoint(x: sliderDiameter / 2, y: sliderDiameter / 2)
//        let a = point.y - center.y
//        let b = point.x - center.x
//        return atan2(a, b)
//    }
//    private func pointFromangle(_ angle: CGFloat) -> CGPoint {
//        let center = CGPoint(x: sliderDiameter / 2, y: sliderDiameter / 2)
//        return CGPoint(x: cos(angle)*(sliderDiameter/2)+center.x, y: sin(angle)*(sliderDiameter/2)+center.y)
//    }
//
//    private func handleDrag(value: CGPoint) {
//        //set which knob is being changed
//        let startKnobPoint = pointFromangle(startRad)
//        let endKnobPoint = pointFromangle(endRad)
//        let distancetoStart = distanceBetween(startKnobPoint, value)
//        let distancetoEnd = distanceBetween(endKnobPoint, value)
//        if distancetoStart>distancetoEnd{
//            sliderLock = .start
//        }
//        else{
//            sliderLock = .end
//        }
//        //detect angle
//        let angle = anglefromPoint(value)
//        let snappedAngle = round(angle / (min5Snap * .pi / 180)) * min5Snap * .pi / 180
//        if sliderLock == .start{
//            startRad = snappedAngle
//        }
//        else {
//            endRad = snappedAngle
//        }
//        
//    }
//
//    private func distanceBetween(_ point1: CGPoint, _ point2: CGPoint) -> CGFloat {
//        return sqrt(pow(point1.x - point2.x, 2) + pow(point1.y - point2.y, 2))
//    }
//
//    @State var color: Color = .blue
//    @State var color1: Color = .blue
//    @State private var tapped: Bool = false
//    @State private var position: CGPoint = .zero
//    @State private var position2: CGPoint = .zero
//    
//    func handleDrag2(value: CGPoint) -> CGFloat {
//        let angle = anglefromPoint(value)
//        return angle
//    }
//    clockSlider4.endRad = CGFloat.pi * -(3/6)
//    var body: some View {
//        // TODO: detect the closest handleview and  move it
//        // - make function to check the closest snap to click
//        // - make function to check the distance
//        // TODO: change the state into whichever being clicked
//        // TODO: make it move to the nearest snap based on detected location
//        VStack {
//            ZStack {
//                Color.red
//                clockSlider4
//                    .gesture(
//                        DragGesture(minimumDistance: 0)
//                            .onChanged { value in
//                                self.handleDrag(value: value.location) // the pressed white handle location
//                                print("after: \(value.location)")
//                            }
//                            .onEnded { value in
//                                circlePosition = value.location
//                                print("Clicked at: \(value.location)")
//                                self.sliderLock = .none // change the handledrag to none when it stopped being pressed
//                            }
//                    )
//            }
//        }
//    }
//}
//
////    private func handleDrag(value: CGPoint) {
////        let angle = angleFromPoint(value) //touch radian value of angle from center
////
////        // Snapping the angle to hourly intervals (30 degrees)
////        let snappedAngle = round(angle / (min5Snap * .pi / 180)) * min5Snap * .pi / 180
////        //round the location to the closest 5 min snap point
////
////        // Lock the nearest knob
////        if sliderLock == .start { //first pressed rad angle
////            startAngle = snappedAngle
////        } else if sliderLock == .end { //handle bar last pressed rad angle
////            endAngle = snappedAngle
////        }
////
////        // Determine which knob to lock, returns point from angle
////        let startKnobPoint = pointFromAngle(startAngle)
////        let endKnobPoint = pointFromAngle(endAngle)
////        // which knob is being pressed based on the distance clicked
////        let distanceToStart = distanceBetween(value, startKnobPoint)
////        let distanceToEnd = distanceBetween(value, endKnobPoint)
////
////        if distanceToStart < distanceToEnd {
////            sliderLock = .start
////        } else {
////            sliderLock = .end
////        }
////    }
////    var body: some View {
////        ZStack {
////            GeometryReader { geometry in
////                self.content
////            }
////            .edgesIgnoringSafeArea(.all)
////        }
////    }
//
//#Preview {
//    Responsive()
//        .preferredColorScheme(.dark)
//}
