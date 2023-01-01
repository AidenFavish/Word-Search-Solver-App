//
//  ContentView.swift
//  WordSearchSolver2.0
//
//  Created by Aiden Favish on 12/31/22.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    
    @State private var startScanning = false
    @State private var scanText = ""
    var width: Int
    var height: Int
    
    var body: some View {
        VStack(spacing: 0) {
            //DataScanner(startScanning: $startScanning, scanText: $scanText, width: width, height: height)
                //.frame(height: 400)
         
            Text(scanText)
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
                .background(in: Rectangle())
                .backgroundStyle(Color(uiColor: .systemGray6))
         
        }
        .task {
            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                startScanning.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(width: 1, height: 1)
    }
}
