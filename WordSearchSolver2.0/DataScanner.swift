//
//  DataScannerController.swift
//  LiveTextDemo
//
//  Created by Simon Ng on 14/6/2022.
//
import SwiftUI
import UIKit
import VisionKit

struct DataScanner: UIViewControllerRepresentable {
    
    @Binding var startScanning: Bool
    @Binding var scanText: String
    @Binding var jumble: String
    var width: Int
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text()],
                            qualityLevel: .accurate,
                            isHighlightingEnabled: true
                        )
        
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        
        if startScanning {
            try? uiViewController.startScanning()
        } else {
            uiViewController.stopScanning()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, width)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DataScanner
        var width: Int
        
        init(_ parent: DataScanner, _ width: Int) {
            self.parent = parent
            self.width = width
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            switch item {
            case .text(let text):
                var ans1 = ""
                var ans2 = ""
                let raw = text.transcript.uppercased()
                let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
                
                for i in 0...raw.count-1 {
                    if alphabet.contains(raw[i]) {
                        ans1 += raw[i]
                    }
                }
                
                for i in 0...ans1.count-1 {
                    if (i+1) % width == 0 && i != ans1.count-1 {
                        ans2 += ans1[i] + "\n"
                    } else {
                        ans2 += ans1[i]
                    }
                }
                
                if ans1.count % width == 0 {
                    parent.scanText = ans2
                    parent.jumble = ans1
                } else {
                    parent.scanText = "Error detected scan again"
                    parent.jumble = ans1
                }
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
                
            default: break
            }
        }
        
    }
}
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
