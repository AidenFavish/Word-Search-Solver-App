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
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                DataScanner(startScanning: $startScanning, scanText: $scanText, width: width)
                    .frame(height: 300)
                    .cornerRadius(25)
                    .clipped()
                    .padding()
             
                Text(scanText)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity)
             
            }
            .task {
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    startScanning.toggle()
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
