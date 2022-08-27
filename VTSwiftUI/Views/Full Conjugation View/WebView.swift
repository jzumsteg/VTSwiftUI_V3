//
//  WebView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/14/22.
//


import SwiftUI
import WebKit
 
import WebKit
import SwiftUI

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
