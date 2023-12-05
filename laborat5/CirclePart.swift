//
//  CirclePart.swift
//  laborat5
//
//  Created by student on 28/11/2023.
//

import SwiftUI
import CoreGraphics

//struct CirclePart: Shape {
//    let startAngle : Angle = .degrees(-90)
//    var endAngle : Angle
//    
//    init(_ endAngle: Angle){
//        self.endAngle = endAngle - .degrees(90)
//    }
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        
//        let width  = rect.midX
//        let height = rect.midY
//
//        path.move(to: CGPoint(x: width, y: height))
//        path.addArc(center: CGPoint(x: width, y: height), radius: 150, startAngle: startAngle, endAngle: endAngle, clockwise: false)
//
//        return path
//    }
//}
//    
//
//
//#Preview {
//    CirclePart(.degrees(240))
//        .fill(.cyan)
//}

struct CirclePart: Shape {
    var startAngle: Angle = .zero
    let endAngle: Angle
    var clockwise = true
    
    func path(in rect: CGRect) -> Path {
        let startAngle = startAngle - .degrees(90)
        let endAngle = endAngle - .degrees(90)
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(startAngle.radians),
            y: center.y + radius * sin(startAngle.radians)
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: !clockwise
        )
        p.addLine(to: center)
        return p
    }
}

#Preview{
    CirclePart(endAngle: .degrees(240))
}
