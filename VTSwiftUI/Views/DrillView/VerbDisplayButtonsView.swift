//
//  VerbDisplayButtonsView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 1/12/22.
//

import SwiftUI

struct VerbDisplayButtonsView: View {
    @State var showConjugationView = false
    @State var showAddVerbListView = false
    @State var addOrRemoveAction: addRemoveVerbAction = .add
    @Binding var verbSelectMode: Quiz_selection_mode
    @Binding var showAnswerSwitch: Bool
    @EnvironmentObject var environmentals: EnvironmentalObjects
    @EnvironmentObject var verbGenerator: VerbGenerator
    @EnvironmentObject var model: DrillViewModel
    @State var showAlert: Bool = false
    @State var inf: String = ""
    var fontSize = CGFloat(14)
    var buttonHeight = CGFloat(35)

    var body: some View {
        ZStack {
//            PrintFromView(environmentals.currentVerblist)
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showAddVerbListView = true
                    }) {
                        // if mode = .use_verb_list then show an alert to confirm that user wants to delete this verb from the current list
                        if environmentals.currentDisplayMode == .use_verb_list {
                            Text("Remove from \"\(Params.shared.currentSelectedVerblist!.name)\"")
                                .padding(.leading, 12)
                                .font(.system(size: fontSize))
                                .frame(height: buttonHeight)

                                .onTapGesture {
//                                    _ = PrintFromView("Put up alert")
                                    showAlert = true

                                }
                        }
                        else {
                            Text("Add to verb list")
                                .frame(height: buttonHeight)
                                .font(.system(size: fontSize))
                                .padding(.leading, 10)
                                .onTapGesture {
//                                    _ = PrintFromView("Go to add to verblist view")
                                    showAddVerbListView = true
                                }
                        }

                    }
                    .padding(.trailing, 10)
                    .buttonStyle(RoundedRectangleButtonStyle())
                    
                    Button(action: {
                        self.showConjugationView = true
                    }) {
                        Text("Conjugation")
                            .font(.system(size: fontSize))
                            .frame(height: buttonHeight)

                    }
                    .buttonStyle(RoundedRectangleButtonStyle())
                    .navigationBarTitle("Main view", displayMode: .inline)
                    .padding(.leading, 10)
                    Spacer()
                    
                    
                }  // HStack:27
//                .fixedSize(horizontal: true, vertical: true)
                
                HStack {
                    Button{
                        print("Go back")
                        model.historyStack.print()
                        if model.historyStack.canGoBackward() {
                            verbGenerator.displayVerb = model.historyStack.goBackOne()
                            showAnswerSwitch = false
                            
                        }
                    } label: {
                        Image(systemName: "backward.frame")
                    }
                    .padding(.leading, 40)
                    Spacer()
                    Text("\(showAnswerSwitch ? "Tap Screen for next drill" : "Tap screen for answer")")
                        .italic()
                        .frame(width: 200)
                        .fixedSize(horizontal: true, vertical: true)
                        .foregroundColor(Color.red)

                    Spacer()
                    Button{
                        print("Go forward")
                        if model.historyStack.canGoForward() {
                            verbGenerator.displayVerb = model.historyStack.goForwardOne()
                            showAnswerSwitch = false
                        }
                    } label: {
                        Image(systemName: "forward.frame")
                    }
                    .padding(.trailing, 40)
                    
                } // HStack:77
//                .padding(.bottom, 25)
            } // VStack:26
            .frame(height:100)
//            .frameSize(color: Color.red)
        } // ZStack:24
        .sheet(isPresented: $showConjugationView) {
            FullConjugationView(inf: verbGenerator.displayVerb.infinitive, closeSwitch: $showConjugationView)
        } // .sheet:112
        .sheet(isPresented: $showAddVerbListView) {
            AddToVerbListView(showAddRemoveView: $showAddVerbListView)
                .environmentObject(environmentals)
        } // .sheet:115
        
        .alert(isPresented: $showAlert) {
            return Alert(title: Text("Please Confirm"), message: Text("Do you really want to delete \"\(verbGenerator.displayVerb.infinitive)\" from the verb list \"\(verbGenerator.currentVerbList.name)\"?"),
            primaryButton: .cancel(Text("Yes, delete it"), action: {
//                guard let idx = verbGenerator.currentVerbList.infinitives.lastIndex(of: verbGenerator.displayVerb.infinitive) else {return}
                let inf = verbGenerator.displayVerb.infinitive
                guard let idx = verbGenerator.currentVerbList.infinitives.firstIndex(where: { $0 == inf }) else {return}
                verbGenerator.currentVerbList.infinitives.remove(at: idx)
                verbGenerator.currentVerbList.save()
                verbGenerator.getVerb()
                environmentals.allVerbLists.verblists = Verblists().verblists
                
            }),
            secondaryButton: .default(Text("Cancel"), action: {
                
            }))
        }
    } // varbody:someView:23
}

//struct VerbDisplayButtonsView_Previews: PreviewProvider {
//    static var previews: some View {
//        VerbDisplayButtonsView()
//    }
//}

//struct RoundedRectangleButtonStyle: ButtonStyle {
//  func makeBody(configuration: Configuration) -> some View {
//    HStack {
//      Spacer()
//      configuration.label.foregroundColor(.black)
//      Spacer()
//    }
//    .padding(.leading, 5)
//    .padding(.trailing, 10)
//    .padding(.top, 10)
//    .padding(.bottom, 10)
////    .background(Color.blue.cornerRadius(8))
//    .background(Color("LightBlueBackground").cornerRadius(6))
//    .scaleEffect(configuration.isPressed ? 0.90 : 1)
//    .font(.system(size: 14, weight: .regular, design: .default))
//  }
//}
