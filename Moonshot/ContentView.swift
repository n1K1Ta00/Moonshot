//
//  ContentView.swift
//  Moonshot
//
//  Created by Никита Мартьянов on 5.08.23.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showGrid = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Toggle(isOn: $showGrid) {
                        Text("Show Grid")
                    }
                    .padding()
                    
                    if showGrid {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                                    MissionGridItemView(mission: mission)
                                }
                            }
                        }
                        .padding([.horizontal,.bottom])
                    } else {
                        List(missions) { mission in
                            NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                                MissionListItemView(mission: mission)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .background(Color.black)
            .preferredColorScheme(.dark)
        }
    }
}

struct MissionGridItemView: View {
    let mission: Mission
    
    var body: some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 120,height: 120)
                .padding()
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth:.infinity)
            .background(Color.gray)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius:10)
                .stroke(Color.gray))
    }
}

struct MissionListItemView: View {
    let mission: Mission
    
    var body: some View {
        HStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding()
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                
                Text(mission.formattedLaunchDate)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
