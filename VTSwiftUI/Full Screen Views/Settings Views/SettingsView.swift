//
//  SettingsView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/11/21.
//

import SwiftUI
import UIKit
import MessageUI

struct SettingsView: View {
    @EnvironmentObject var environmentObjects: EnvironmentalObjects
    @State var verbSelectionMenuOpen: Bool = true
    @State var showDisplayOptionsView: Bool = false
    @State var showTenseLocaleView: Bool = false
    
    // for email
    @State var isShowingMailView = false
    @State var alertNoMail = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    
    var textFontSize = 12.0
    var buttonSize = 60.0
    var imageSize = 30.0
    var borderLineWidth = 2.0
    var body: some View {
        VStack {
            GeometryReader { geo in
                NavigationView {
                    VStack {
                        Text("Settings")
                            .font(.system(size:32))
                        HStack {
//                            Spacer()
                            HStack {
                                Spacer()
                            } // HStack:36
                            NavigationLink(destination: VerbListView(environmentalObjects: environmentObjects)) {
                                SettingsButtonView(captionStr: "Verb Lists", imageStr: "list.bullet.rectangle")
//                                    .environmentObject(environmentObjects)
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            NavigationLink(destination: DisplayOptionsView(showDisplayOptionsView: $showDisplayOptionsView)) {
                                SettingsButtonView(captionStr: "Display Options", imageStr: "display")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            NavigationLink(destination: ConjugationChoiceView(infStr: $environmentObjects.selectedInfinitive)) {
                                SettingsButtonView(captionStr: "Conjugation", imageStr: "server.rack")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            HStack {
                                Spacer()
                            } // HStack:36
                            
                        } // HStack:34
                        HStack {
                            HStack {
                                Spacer()
                            } // HStack:89
                            
                            NavigationLink(destination: HTMLView(htmlFileName: "help.html", whichView: .help_view)) {
                                SettingsButtonView(captionStr: "Help", imageStr: "questionmark")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }

//                        .border(Color.orange)
                        

//                            Spacer()
                            NavigationLink(destination: HTMLView(htmlFileName: "sampleConjugation.html", whichView: .sample_conjugation)) {
                                SettingsButtonView(captionStr: "Sample Conj.", imageStr: "list.bullet.rectangle")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            NavigationLink(destination: HTMLView(htmlFileName: "changes.html", whichView: .changes_view)) {
                                SettingsButtonView(captionStr: "Changes", imageStr: "arrow.up.right.and.arrow.down.left.rectangle")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            HStack {
                                Spacer()
                                
                            } // HStack:149
                        } // HStack:88
//                        .border(Color.black)
                        HStack {
                            HStack {
                                Spacer()
                            } // HStack:89
                            NavigationLink(destination: HTMLView(htmlFileName: "info.html", whichView: .info_view)) {
                                SettingsButtonView(captionStr: "Information", imageStr: "info.circle")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .foregroundColor(Color("ViewForeground"))
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            
                            SettingsButtonView(captionStr: "Contact Dev", imageStr: "envelope")
                                .onTapGesture {
                                    if MFMailComposeViewController.canSendMail() {
                                        self.isShowingMailView.toggle()
                                    } else {
                                        print("Can't send emails from this device")
                                    }
                                    if result != nil {
                                        print("Result: \(String(describing: result))")
                                    }
                                }
                                .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                )
                                .background(Color.clear)
                                .foregroundColor(Color("ViewForeground"))
                                .fixedSize(horizontal: false, vertical: true)

                            NavigationLink(destination: TenseLocaleView(showTenseLocaleView: $showTenseLocaleView)) {
                                SettingsButtonView(captionStr: "Tense Locale.", imageStr: "list.bullet.rectangle")
                                    .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color("ButtonBorder"), lineWidth: borderLineWidth)
                                    )
                                    .background(Color.clear)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
                        } // HStack:88
                        
                        Spacer()
                    } // VStack:32
                    .frame(width: max(390, geo.size.width * 0.9))
     
//                    .background(Color.green)
//                    .opacity(0.2)

                } // NavigationView:31
                .navigationViewStyle(.stack)
            } // GeometryReader:30
            Spacer()
        } // VStack:28
//        .background(Color.red)
//        .opacity(0.1)
        
        
        .sheet(isPresented: $isShowingMailView) {
            MailView(result: $result)
        } // .sheet:169
    } // varbody:someView:27
}


//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
