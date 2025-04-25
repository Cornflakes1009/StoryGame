//
//  GameModel.swift
//  StoryGame
//
//  Created by Harold Davidson on 4/22/25.
//

import Foundation

struct GameScene {
    let id: String
    let text: String
    let options: [GameOption]
}

struct GameOption {
    let title: String
    let nextSceneID: String
}

// MARK: - Sample Data
let scenes: [String: GameScene] = [
    "start": GameScene(
        id: "start",
        text: "You wake up in a dark forest. Paths lead north and east.",
        options: [
            GameOption(title: "Go north", nextSceneID: "north"),
            GameOption(title: "Go east", nextSceneID: "east")
        ]
    ),
    "north": GameScene(
        id: "north",
        text: "You arrive at a spooky cave. A cold wind blows.",
        options: [
            GameOption(title: "Enter the cave", nextSceneID: "cave"),
            GameOption(title: "Return to forest", nextSceneID: "start")
        ]
    ),
    "east": GameScene(
        id: "east",
        text: "You find a quiet pond. It's peaceful here.",
        options: [
            GameOption(title: "Drink from the pond", nextSceneID: "end"),
            GameOption(title: "Return to forest", nextSceneID: "start")
        ]
    ),
    "cave": GameScene(
        id: "cave",
        text: "Inside the cave you find treasure... and a dragon!",
        options: [
            GameOption(title: "Fight the dragon", nextSceneID: "end"),
            GameOption(title: "Run away", nextSceneID: "start")
        ]
    ),
    "end": GameScene(
        id: "end",
        text: "The story ends here. Thanks for playing!",
        options: [
            GameOption(title: "Restart", nextSceneID: "start")
        ]
    )
]

