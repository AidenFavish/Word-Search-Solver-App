//
//  SearchScanner.swift
//  WordSearchSolver2.0
//
//  Created by Aiden Favish on 1/1/23.
//

import SwiftUI
import VisionKit

struct SearchScanner: View {
    
    @State private var startScanning = false
    @State private var scanText = ""
    var width: Int
    var height: Int
    @State var jumble = ""
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                DataScanner(startScanning: $startScanning, scanText: $scanText, jumble: $jumble, width: width)
                    .frame(height: 300)
                    .cornerRadius(25)
                    .clipped()
                    .padding()
             
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.gray)
                        .opacity(0.25)
                    
                    Text(scanText)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        
                }.padding(.horizontal)
                
                NavigationLink(destination: Searcher(width: width, height: height, Jumble: jumble, display1: NSMutableAttributedString.init(string: scanText))) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 125, height: 40)
                            .foregroundColor(.blue)
                        Text("Confirm")
                            .foregroundColor(.white)
                    }
                }.padding()
                    .padding(.top)
             
            }
            .task {
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    startScanning.toggle()
                } else {
                    scanText = "Text scanning is not\nsupported by your device"
                }
            }
        }.navigationTitle("Tap to scan")
    }
}

struct SearchScanner_Previews: PreviewProvider {
    static var previews: some View {
        SearchScanner(width: 1, height: 1)
    }
}
