//
//  ScanView.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI

struct ScanView: View {
    @ObservedObject var bluetoothManager = BLEManager()

    var body: some View {
        VStack {
            NavigationView {
                List(bluetoothManager.discoveredDevices, id: \.self) { device in
                    Text(device.name ?? "Unnamed Device")
                }
                .navigationBarTitle("Bluetooth Devices")
                .onAppear {
                    // Start scanning for devices when the view appears
                    bluetoothManager.connect()
                }
            }
            
            Spacer()
            VStack {
                PrimaryButton(buttonLabel: "Scan", color: .purple) {
                    bluetoothManager.startScanning()
                }
                .padding()
            }
        }
    }
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanView()
    }
}
