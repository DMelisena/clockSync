//
//  ClockTime.swift
//  clockSync
//
//  Created by Arya Hanif on 27/04/25.
//

import SwiftUI

struct ClockTime: View {
    func hourToRad(_ hour: CGFloat) -> CGFloat {
        return hour*CGFloat.pi/6
    }
    func radtoHour(_ rad: CGFloat) -> CGFloat {
        return rad * 6 / CGFloat.pi
    }
    @State var clockSlider4 = ClockSlider4()
//    init(){
//        clockSlider4.startRad = hourToRad(-3)
//        clockSlider4.endRad = hourToRad(6)
//    }

    init() {
        _clockSlider4 = State(initialValue: ClockSlider4(startRad: hourToRad(-5), endRad: hourToRad(6)))
    }
    var getTime: CGFloat {
        var timeLengthRad = abs(clockSlider4.endRad-clockSlider4.startRad)
        if clockSlider4.endRad < clockSlider4.startRad {
            timeLengthRad += CGFloat.pi * 2
        }
        return timeLengthRad/CGFloat.pi * 12
    }
    var body: some View {
        Text("\(getTime)")
        Text("\(clockSlider4.startRad)")
        Text("\(radtoHour(clockSlider4.startRad))")
        Text("\(clockSlider4.endRad)")
        Text("\(radtoHour(clockSlider4.endRad))")
        Text("\(getTime)")
        clockSlider4
    }
    
}

#Preview {
    ClockTime()
    ClockSlider4()
}
