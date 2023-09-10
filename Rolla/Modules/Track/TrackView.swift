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
                            VStack(alignment: .leading) {
                                Text("Current speed:")
                                    .font(.system(.title))
                                Text("\(gpsTracker.currentSpeed.toString()) m/s")
                                    .font(.system(.title))
                                    .foregroundColor(.purple)
                            }
                        }
                        Spacer()
                    }
                    VSpacer(16)
                    HStack {
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text("Traveled distance:")
                                    .font(.system(.title))
                                Text("\(gpsTracker.traveledDistance.toString()) meters")
                                    .font(.system(.title))
                                    .foregroundColor(.purple)
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    LottieView(animationName: "gps-tracker", loopMode: .playOnce)
                        .frame(width: 100, height: 100)
                        .scaleEffect(0.4)
                }
                
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
