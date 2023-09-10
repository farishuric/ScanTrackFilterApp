//
//  ScanView.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI

struct ScanView: View {
    @ObservedObject var scanVM = ScanViewModel()
    private var isScanning = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    List(scanVM.discoveredDevices, id: \.self) { device in
                        NavigationLink {
                            ScanDetailsView(device: device)
                        } label: {
                            Text("Device: \(device.name ?? "Unknown name")")
                        }


                    }
                    .navigationBarTitle("Bluetooth Devices")
                    .onAppear {
                        // Start scanning for devices when the view appears
                        scanVM.startConnection()
                    }
                    .overlay(Group {
                        if scanVM.discoveredDevices.isEmpty {
                            if scanVM.isScanning {
                                Text("No devices found...")
                            } else {
                                Text("Tap Scan to find nearby devices")
                            }
                        }
                    })
                    
                }
                
                Spacer()
                
                VStack {
                    LottieView(animationName: "bluetooth-lottie", loopMode: .loop)
                        .frame(width: 100, height: 100)
                        .scaleEffect(0.2)
                }
                
                Spacer()
                
                VStack {
                    PrimaryButton(
                        buttonLabel: isScanning ? "Stop scanning" : "Scan",
                        color: .purple
                    ) {
                        scanVM.isScanning ? scanVM.stopScanning() : scanVM.startScanning()
                        scanVM.isScanning.toggle()
                    }
                    .padding()
                }
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
