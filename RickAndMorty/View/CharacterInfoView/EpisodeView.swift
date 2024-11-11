//
//  EpisodeView.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 10.11.2024.
//

import SwiftUI

struct EpisodeCell: View {
    
    let episode:Episode
    
    var body: some View {
        Text(episode.name)
    }
}

#Preview {
    EpisodeCell(episode: Episode(data: ["name" : "episode_1"]))
}
