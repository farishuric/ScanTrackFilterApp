//
//  BluetoothManager.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var discoveredDevices: [CBPeripheral] = []

    let DEVICE_SERVICE_UUID = CBUUID.init(string: "b4250400-fb4b-4746-b2b0-93f0e61122c6");
    var centralManager: CBCentralManager!;
    var peripheral: CBPeripheral!;
    
    func connect() {
        centralManager = CBCentralManager(delegate: self, queue: .global());
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central state update")
        if central.state != .poweredOn {
            print("Central is not powered on")
        } else {
            print("Central scanning for", DEVICE_SERVICE_UUID);
            centralManager.scanForPeripherals(withServices: [DEVICE_SERVICE_UUID],
                                              options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
        }
    }
    
    // Handles the result of the scan
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        discoveredDevices.append(peripheral)
        // We've found it so stop scan
        self.centralManager.stopScan()
        
        // Copy the peripheral instance
        self.peripheral = peripheral
        self.peripheral.delegate = self
        
        // Connect!
        self.centralManager.connect(self.peripheral, options: nil)
        
        
    }
    
    // The handler if we do connect succesfully
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral {
            print("Connected to BLE device")
            peripheral.discoverServices([DEVICE_SERVICE_UUID]);
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if peripheral == self.peripheral {
            print("Disconnected");
            self.peripheral = nil;
            // Start scanning again
            print("Central scanning for", DEVICE_SERVICE_UUID);
            centralManager.scanForPeripherals(withServices: [DEVICE_SERVICE_UUID],
                                              options: [CBCentralManagerScanOptionAllowDuplicatesKey : true]);
        }
    }
    
    // Handles discovery event
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == DEVICE_SERVICE_UUID {
                    print("LED service found")
                    //Now kick off discovery of characteristics
                    peripheral.discoverCharacteristics([DEVICE_SERVICE_UUID], for: service)
                }
            }
        }
    }
    
    func startScanning() {
        centralManager.scanForPeripherals(withServices: nil)
    }
}
