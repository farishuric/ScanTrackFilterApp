//
//  TrackView.swift
//  Rolla
//
//  Created by Faris Hurić on 10. 9. 2023..
//

import SwiftUI

struct TrackView: View {
    @ObservedObject var gpsTracker = GPSTrackerManager()
    @State var isTracking = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            VStack {
                                Text("Current speed: \(gpsTracker.currentSpeed)m/s")
                                    .font(.system(.title))
                            }
                        }
                        Spacer()
                    }
                    VSpacer(16)
                    HStack {
                        VStack(alignment: .leading) {
                            VStack {
                                Text("Traveled Distance: \(gpsTracker.traveledDistance) meters")
                                    .font(.system(.title))
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    PrimaryButton(
                        buttonLabel: isTracking ? "Stop tracking" : "Start tracking",
                        color: .purple
                    ) {
                        isTracking ? gpsTracker.stopTracking() : gpsTracker.startTracking()
                        isTracking.toggle()
                    }
                }
                .padding()
            }
            .navigationTitle("GPS Tracker")
        }
    }
    
}

struct TrackView_Previews: PreviewProvider {
    static var previews: some View {
        TrackView()
    }
}
