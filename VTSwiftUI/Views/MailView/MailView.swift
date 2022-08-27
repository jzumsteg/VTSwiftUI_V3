//
//  MailView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 2/26/22.
//

import Foundation
import UIKit
import SwiftUI
import MessageUI

public struct MailView: UIViewControllerRepresentable {

    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    public var configure: ((MFMailComposeViewController) -> Void)?

    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {

        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>) {
            _presentation = presentation
            _result = result
        }

        public func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
        }
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result)
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
//        let vc = MFMailComposeViewController()
        let vc = configuredMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        configure?(vc)
        return vc
    }

    public func updateUIViewController(
        _ uiViewController: MFMailComposeViewController,
        context: UIViewControllerRepresentableContext<MailView>) {

    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let iosDevice = UIDevice.current.model
        let iosSystemVersion = UIDevice.current.systemVersion
        let iosSystemName = UIDevice.current.systemName
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")!
        let userMsg = "Please enter your comment/bug/suggestion below:\n\n\n\n-------------------\nApp version: \(appVersion)\niOS: \(iosSystemVersion)\nSystem Name: \(iosSystemName)\nDevice: \(iosDevice)\n-------------------"
        let mailComposerVC = MFMailComposeViewController()
//        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate--  / property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["support@verbtrainers.com", "john@zumsteg.us"])
        mailComposerVC.setSubject("\(LanguageGlobals.appTitle) Bug report/Comment")
        mailComposerVC.setMessageBody(userMsg, isHTML: false)
        
        return mailComposerVC
    }

}
