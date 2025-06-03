//
//  Rick_MortyApp.swift
//  Rick&Morty
//
//  Created by David Ortego on 28/5/25.
//

import SwiftUI

@main
struct Rick_MortyApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView()
                .environment(CharactersViewModel())
        }
    }
}
