//
//  EventListRow.swift
//  EventSearch
//
//  Created by Desmond Wu on 4/21/23.
//

import SwiftUI

struct EventListRow: View {
    let event: EventItem
    
    var body: some View {
        NavigationLink(destination: EventDetailsView(eventId: event.id)){
            HStack() {
                if let time = event.time {
                    let components = time.components(separatedBy: ":")
                    let formattedTime = components[0] + ":" + components[1]
                    Text("\(event.date)|\(formattedTime)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text(event.date)
                        .foregroundColor(.secondary)
                }
                
                AsyncImage(url: URL(string: event.image)) { image in
                    image.resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
                
                Text(event.event)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)

                
                Text(event.venue)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            
            }
            .padding(.vertical)
        }
    }
}

struct EventListRow_Previews: PreviewProvider {
    static var events = [
        EventItem(id: "vvG10Z9Nl79EZG",
                  date: "2023-04-21",
                  time: "20:00:00",
                  image: "https://s1.ticketm.net/dam/a/169/8198c6ff-f2b6-4724-ad38-3cb99efd7169_RETINA_LANDSCAPE_16_9.jpg",
                  event: "Azjah + Friends 2 Concert",
                  venue: "The Echo"),
        EventItem(id: "vvG10Z9prnV3WH",
                  date: "2023-04-27",
                  time: nil,
                  image: "https://i.ticketweb.com/i/00/11/91/61/49_Edp.jpg",
                  event: "Spencer Sutherland - VIP M&G Upgrade- THIS IS NOT A CONCERT TICKET",
                  venue: "The Belasco"),
        EventItem(id: "vvG10Z9N5ZwpeM",
                  date: "2023-04-29",
                  time: "20:00:00",
                  image: "https://s1.ticketm.net/dam/a/e7a/485328fc-1007-4f91-b669-c0cbf6a61e7a_176551_TABLET_LANDSCAPE_LARGE_16_9.jpg",
                  event: "Ne-Yo, Robin Thicke & Mario Live In Concert!",
                  venue: "Greek Theatre")
    ]
    
    
    static var previews: some View {
        NavigationView {
            List {
                EventListRow(event: events[0])
                EventListRow(event: events[1])
                EventListRow(event: events[2])
            }
        }
        
    }
}
