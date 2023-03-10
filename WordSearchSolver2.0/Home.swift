//
//  Home.swift
//  WordSearchSolver2.0
//
//  Created by Aiden Favish on 12/31/22.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: DimensionPrompt()) {
                            Image("StartScanner")
                                .resizable()
                                .frame(width: 200, height: 250)
                                .cornerRadius(30)
                        }
                        Spacer()
                    }.padding(.vertical)
                    
                    /*Label("History", systemImage: "clock.arrow.circlepath")
                        .font(.title2)*/
                    Text("Disclaimer: The current scanning mechanism uses Live Text, which is not meant for scanning large word searches. A new specialized scanner is currently in the works to fix accuracy issues.")
                        .padding()
                        .multilineTextAlignment(.center)
                    
                }.navigationTitle("Home")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
