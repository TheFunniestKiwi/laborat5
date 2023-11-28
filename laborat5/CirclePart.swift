//
//  CirclePart.swift
//  laborat5
//
//  Created by student on 28/11/2023.
//

import SwiftUI

struct CirclePart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width  = rect.midX
        let heght = rect.midY
        path.move(to: CGPoint(x: 200, y: 350))
        path.addArc(center: CGPoint(x: 200, y: 350), radius: 150, startAngle: .degrees(160), endAngle: .degrees(90), clockwise: false)
        
        return path
    }
}
    


#Preview {
    CirclePart()
        .fill(.green)
}
