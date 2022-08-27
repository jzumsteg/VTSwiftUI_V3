//
//  ContentView.swift
//  VTSwiftUI
//
//  Created by John Zumsteg on 11/11/21.
//

import SwiftUI
//class Orientation: ObservableObject {
//    @Published var isLandscape: Bool = UIDevice.current.orientation.isLandscape
//}

struct ContentView: View {
    @Environment(\.colorScheme) var currentColorMode
    @StateObject var environmentals = EnvironmentalObjects()
    @StateObject var verbGenerator = VerbGenerator.shared
    @StateObject var verblistManagement = VerblistManagementModel()
    
    @State var verbSelectionMenuOpen: Bool = false
    @State var showAnswerSwitch: Bool = false
    @State var selectedTab: String = "" {
        didSet {
            Params.shared.selectedTab = selectedTab
            Log.print("selectedTab: \(selectedTab)")
        }
    }
    
    @StateObject var orientation = Orientation()
    @State var initialOrientationIsLandScape = false
    let orientationChanged = NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
        .makeConnectable()
        .autoconnect()
    
    init() {
        Log.print("ContentView.init", logLevel: 2)
        FileUtilities.createVerbListDirectory()
    }
    
    var body: some View {
        
        TabView (selection: $selectedTab) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                DrillView_pad(showAnswerSwitch: $showAnswerSwitch)
                    .onReceive(orientationChanged, perform: { _ in
                        if initialOrientationIsLandScape {
                            initialOrientationIsLandScape = false
                        } else {
                            orientation.isLandscape = UIDevice.current.orientation.isLandscape
                        }
                    })
                    .onAppear {
                        orientation.isLandscape = UIDevice.current.orientation.isLandscape
                        initialOrientationIsLandScape = orientation.isLandscape
                    }
//                    .onReceive(orientationChanged, perform: { _ in
//                        if initialOrientationIsLandScape {
//                            initialOrientationIsLandScape = false
//                        } else {
//                            orientation.isLandscape = UIDevice.current.orientation.isLandscape
//                        }
//                    })
                    .tabItem {
                        Image(systemName: "note.text")
                        Text("Drill View")
                    }
                    .onTapGesture {
//                        Log.print("tapped drill")
                        environmentals.selectedTab = "drill"
                        Params.shared.selectedTab = "drill"                }
                    .tag("drill")
            }
            else {
                DrillView_phone(showAnswerSwitch: $showAnswerSwitch)
                    .tabItem {
                        Image(systemName: "note.text")
                        Text("Drill View")
                    }
                    .onTapGesture {
//                        Log.print("tapped drill")
                        environmentals.selectedTab = "drill"
                        Params.shared.selectedTab = "drill"                }
                    .tag("drill")
            }
            
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                TestView_pad()
                    .onReceive(orientationChanged, perform: { _ in
                        if initialOrientationIsLandScape {
                            initialOrientationIsLandScape = false
                        } else {
                            orientation.isLandscape = UIDevice.current.orientation.isLandscape
                        }
                    })
                    .tabItem {
                        Image(systemName: "person.fill.questionmark")
                        Text("Test View")
                    }
                    .onTapGesture {
//                        print("tapped test")
                        environmentals.selectedTab = "test"
                        Params.shared.selectedTab = "test"
                    }
                    .tag("test")
            }
            else {
                TestView_phone()
                    .tabItem {
                        Image(systemName: "person.fill.questionmark")
                        Text("Test View")
                    }
                    .onTapGesture {
//                        print("tapped test")
                        environmentals.selectedTab = "test"
                        Params.shared.selectedTab = "test"
                    }
                    .tag("test")
            }
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            AutoView_pad(showAnswerSwitch: $showAnswerSwitch)
                .onReceive(orientationChanged, perform: { _ in
                    if initialOrientationIsLandScape {
                        initialOrientationIsLandScape = false
                    } else {
                        orientation.isLandscape = UIDevice.current.orientation.isLandscape
                    }
                })
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("AutoView")
                }
                .onTapGesture {
                    environmentals.selectedTab = "auto"
                    Params.shared.selectedTab = "auto"
                }
                .tag("auto")
        }
        else {
            AutoView_phone(showAnswerSwitch: $showAnswerSwitch)
                .tabItem {
                    Image(systemName: "play.rectangle")
                    Text("AutoView")
                }
                .onTapGesture {
                    environmentals.selectedTab = "auto"
                    Params.shared.selectedTab = "auto"
                }
                .tag("auto")
        }
        
        SettingsSelectionView()
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Verb Selection")
            }
            .tag("selection")
        
        SettingsView()
            .tabItem {
                Image(systemName: "list.bullet.rectangle")
                Text("Other...")
            }
            .tag("settings")
        
    }
        

    
    //        .onChange(of: selectedTab) { newValue in
    //            Log.print("\(newValue)")
    //            Params.shared.selectedTab = newValue
    //        }
        .onAppear {
            //            Log.print("ContentView TabView .onAppear", logLevel: 2)
            selectedTab = environmentals.selectedTab
            
        }
        .environmentObject(verblistManagement)
        .environmentObject(environmentals)
        .environmentObject(verbGenerator)
    
    // put enviromentObjects here to get them into tab views
    
} // varbody:someView:29


func openVerbSelectionMenu() {
    self.verbSelectionMenuOpen.toggle()
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}

// .font(.system(size: 30, weight: .bold, design: .rounded))

