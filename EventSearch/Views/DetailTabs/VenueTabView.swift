//
//  VenueTabView.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/22/23.
//

import SwiftUI

struct VenueTabView: View {
    let eventName: String
    let venueDetails: VenueDetails
    
    @State private var isShowingMap = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(eventName)
                .font(.title3)
                .fontWeight(.bold)
                .padding(.bottom)
                .multilineTextAlignment(.center)
            
            VStack {
                Text("Name")
                    .fontWeight(.bold)
                ScrollableText(text: venueDetails.name)
            }
            
            if let address = venueDetails.address {
                VStack {
                    Text("Address")
                        .fontWeight(.bold)
                    ScrollableText(text: address)
                }
            }
            
            
            if let number = venueDetails.number {
                VStack {
                    Text("Phone Number")
                        .fontWeight(.bold)
                    ScrollableText(text: number)
                }
            }
            
            
            if let openHours = venueDetails.openHours {
                VStack {
                    Text("Open Hours")
                        .fontWeight(.bold)
                    ScrollableText(text: openHours)
                }
            }
            
            if let generalRule = venueDetails.generalRule {
                VStack {
                    Text("General Rule")
                        .fontWeight(.bold)
                    ScrollableText(text: generalRule)
                }
            }
            
            
            if let childRule = venueDetails.childRule {
                VStack {
                    Text("Child Rule")
                        .fontWeight(.bold)
                    ScrollableText(text: childRule)
                }
            }
            
            
            Button(action: {
                isShowingMap = true
            }) {
                Text("Show venue on maps")
                    .padding(.vertical)
                    .padding(.horizontal, 15)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            }
            .buttonStyle(.borderless)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .popover(isPresented: $isShowingMap) {
            MapView(address: venueDetails.address)
        }
    }
}

struct ScrollableText: View {
    let text: String
    
    var body: some View {
        if(text.count <= 130) {
            Text(text)
                .foregroundColor(.secondary)
        }
        else {
            ScrollView {
                Text(text)
                    .foregroundColor(.secondary)
            }
            .frame(height: 65)
        }
    }
}


struct VenueTabView_Previews: PreviewProvider {
    static var venue = VenueDetails(
        name: "Crypto.com Arena",
        address: "1111 S. Figueroa St, Los Angeles, California",
        number: "213-742-7340",
        openHours: "Box office is located on North side of building at 11th and South Figueroa. Box office hours are 10am to 6pm, Monday through Saturday. It is open extended hours on event day. Phone: 213-742-7340 SUMMER HOURS Closed Saturdays and Sundays unless there is an event, the box office will open at 9am on Saturdays or 10am on Sundays only if there is an event. The box office will have extended hours on all event days.",
        generalRule: "No Bottles, Cans, Or Coolers. No Smoking In Arena. No Cameras Or Recording Devices At Concerts! Cameras w/No Flash Allowed For Sporting Events Only!",
        childRule: "Some events require all attendees, regardless of age, to present a ticket for entry. Please check the event ticket policies at the time of purchase. Children age three (3) and above require a ticket for Los Angeles Lakers, Los Angeles Clippers, Los Angeles Kings and Los Angeles Sparks games."
    )
    
    
    static var previews: some View {
        VenueTabView(eventName: "West Conf Qtrs: Round 1 Home Game 1 - Lakers v Memphis Grizzlies", venueDetails: venue)
    }
}
