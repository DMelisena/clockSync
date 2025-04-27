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

    init() {
        _clockSlider4 = State(initialValue: ClockSlider4(startRad: hourToRad(2),
                         endRad: hourToRad(-4)))
    }
    var getTime: CGFloat {
        var timeLengthRad = abs(clockSlider4.endRad-clockSlider4.startRad)
        if clockSlider4.endRad < clockSlider4.startRad {
            timeLengthRad = timeLengthRad * -1
            timeLengthRad += CGFloat.pi*2
        }
        return timeLengthRad/CGFloat.pi*6
    }
    var body: some View {
        Text("\(getTime)")
        Text("\(clockSlider4.startRad)")
        Text("start Time :\(radtoHour(clockSlider4.startRad))")
        Text("\(clockSlider4.endRad)")
        Text("end Time :\(radtoHour(clockSlider4.endRad))")
        Text("\(getTime) hour of sleep")
        clockSlider4
    }
    
}

#Preview {
    ClockTime()
}
