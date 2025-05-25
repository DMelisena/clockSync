//
//  ClockTime.swift
//  clockSync
//
//  Created by Arya Hanif on 27/04/25.
//

import SwiftUI

struct ClockTime: View {
    @State var clockSlider4 = ClockSlider4()
    init() {
        _clockSlider4 = State(initialValue: ClockSlider4(
            startRad: hourToRad(-3.5),
            endRad: hourToRad(5)))
    }
    func hourToRad(_ hour: CGFloat) -> CGFloat {
        return hour*CGFloat.pi/6
    }
    func radtoHour(_ rad: CGFloat) -> CGFloat {
        return rad * 6 / CGFloat.pi
    }

    var getTime: Int{
        var timeLengthRad = abs(clockSlider4.endRad-clockSlider4.startRad)
        if clockSlider4.endRad < clockSlider4.startRad {
            timeLengthRad = timeLengthRad * -1
            timeLengthRad += CGFloat.pi*2
        }
        return Int(timeLengthRad/CGFloat.pi*6)
    }
    func getTimeMore(Endrad: CGFloat, Startrad: CGFloat)-> (rawHour: Double, hour: Int, minutes: Int){
        var timeLengthRad = abs(Endrad-Startrad)
        if clockSlider4.endRad < clockSlider4.startRad {
            timeLengthRad = timeLengthRad * -1
            timeLengthRad += CGFloat.pi*2
        }
        let rawHour = Double(timeLengthRad/CGFloat.pi*6)
        let hour = Int(round(rawHour))
        let minutes = Int(rawHour*60)%60
        return (rawHour, hour, minutes)
    }

    var startTime: CGFloat {
        return radtoHour(clockSlider4.startRad)
    }
    var endTime: CGFloat {
        return radtoHour(clockSlider4.endRad)
    }
    
    var body: some View {
        Text("\(getTime)")
        Text("\(clockSlider4.startRad)")
        Text("start Time :\(startTime)")
        Text("\(clockSlider4.endRad)")
        Text("end Time :\(endTime)")
        Text("\(getTime) hour of sleep")
        Text("\(getTimeMore(Endrad: clockSlider4.startRad, Startrad: clockSlider4.endRad).hour) hour of sleep")
        Text("\(getTimeMore(Endrad: clockSlider4.startRad, Startrad: clockSlider4.endRad).minutes) minute of sleep")
        Text("\(getTime) hour of sleep")
        clockSlider4
    }
    
}

#Preview {
    ClockTime()
        .preferredColorScheme(.dark)
}
