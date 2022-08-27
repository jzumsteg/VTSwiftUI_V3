import Foundation
import SwiftUI

extension View {
    func frameInfo(color: Color, _ caption: String) -> some View {
        modifier(FrameSize(color: color, caption: caption))
    }
}

private struct FrameSize: ViewModifier {
    let color: Color
    let caption: String
    
    func body(content: Content) -> some View {
        content
            .overlay(GeometryReader(content: overlay(for:)))
    }
    
    func overlay(for geometry: GeometryProxy) -> some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top) ) {
            Rectangle()
                .strokeBorder(
                    style: StrokeStyle(lineWidth: 1, dash: [5])
                )
                .foregroundColor(color)
            Text("\(Int(geometry.size.width))x\(Int(geometry.size.height)): \(caption)")
                .font(.custom("Arial", size: 18.0))
                .foregroundColor(color)
                .padding(2)
        }
    }
}
