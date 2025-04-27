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
//let scenes: [String: GameScene] = [
//    "start": GameScene(
//        id: "start",
//        text: "You wake up in a dark forest. Paths lead north and east.",
//        options: [
//            GameOption(title: "Go north", nextSceneID: "north"),
//            GameOption(title: "Go east", nextSceneID: "east")
//        ]
//    ),
//    "north": GameScene(
//        id: "north",
//        text: "You arrive at a spooky cave. A cold wind blows.",
//        options: [
//            GameOption(title: "Enter the cave", nextSceneID: "cave"),
//            GameOption(title: "Return to forest", nextSceneID: "start")
//        ]
//    ),
//    "east": GameScene(
//        id: "east",
//        text: "You find a quiet pond. It's peaceful here.",
//        options: [
//            GameOption(title: "Drink from the pond", nextSceneID: "end"),
//            GameOption(title: "Return to forest", nextSceneID: "start")
//        ]
//    ),
//    "cave": GameScene(
//        id: "cave",
//        text: "Inside the cave you find treasure... and a dragon!",
//        options: [
//            GameOption(title: "Fight the dragon", nextSceneID: "end"),
//            GameOption(title: "Run away", nextSceneID: "start")
//        ]
//    ),
//    "end": GameScene(
//        id: "end",
//        text: "The story ends here. Thanks for playing!",
//        options: [
//            GameOption(title: "Restart", nextSceneID: "start")
//        ]
//    )
//]
//

let scenes: [String: GameScene] = [
    
    "start": GameScene(
        id: "start",
        text: """
        You are Fawn, a young adventurer from the village of Willowmere.
        One misty morning, you discover a hidden path leading into the dark Eldertree Forest.
        Do you dare to follow it?
        """,
        options: [
            GameOption(title: "Follow the hidden path", nextSceneID: "forestEntrance"),
            GameOption(title: "Return to the village", nextSceneID: "villageReturn")
        ]
    ),
    
    "forestEntrance": GameScene(
        id: "forestEntrance",
        text: """
        The forest is dense and full of whispers.
        An old stone well stands to your left, and a narrow deer trail winds deeper to the right.
        """,
        options: [
            GameOption(title: "Investigate the old well", nextSceneID: "oldWell"),
            GameOption(title: "Follow the deer trail", nextSceneID: "deerTrail")
        ]
    ),
    
    "villageReturn": GameScene(
        id: "villageReturn",
        text: """
        You decide the forest is too dangerous for now.
        As you walk back, an elder warns you:
        "Fawn, destiny waits for no one."
        """,
        options: [
            GameOption(title: "Change your mind and head back to the forest", nextSceneID: "forestEntrance"),
            GameOption(title: "Stay in the village and prepare more", nextSceneID: "villagePrepare")
        ]
    ),
    
    "oldWell": GameScene(
        id: "oldWell",
        text: """
        Peering into the well, you see a faint blue glow.
        A rope hangs nearby, swaying gently.
        """,
        options: [
            GameOption(title: "Climb down into the well", nextSceneID: "wellDepths"),
            GameOption(title: "Leave the well and follow the trail", nextSceneID: "deerTrail")
        ]
    ),
    
    "deerTrail": GameScene(
        id: "deerTrail",
        text: """
        The trail twists and turns.
        Suddenly, a shadow leaps across your path — a silver fox with golden eyes.
        """,
        options: [
            GameOption(title: "Follow the silver fox", nextSceneID: "foxChase"),
            GameOption(title: "Ignore it and continue", nextSceneID: "ancientTree")
        ]
    ),
    
    "villagePrepare": GameScene(
        id: "villagePrepare",
        text: """
        You gather supplies: a lantern, bread, and a silver dagger.
        With better preparation, you feel braver to face the unknown.
        """,
        options: [
            GameOption(title: "Set out for Eldertree Forest", nextSceneID: "forestEntrance")
        ]
    ),
    
    "wellDepths": GameScene(
        id: "wellDepths",
        text: """
        Climbing carefully, you reach a hidden chamber.
        A crystal orb floats above a stone pedestal, humming with power.
        """,
        options: [
            GameOption(title: "Touch the orb", nextSceneID: "orbTouched"),
            GameOption(title: "Leave it alone and climb out", nextSceneID: "deerTrail")
        ]
    ),
    
    "foxChase": GameScene(
        id: "foxChase",
        text: """
        You follow the fox through thickets and streams until you arrive at a secret glade.
        In the center grows the Worldroot — an ancient tree older than time itself.
        """,
        options: [
            GameOption(title: "Approach the Worldroot", nextSceneID: "ancientTree"),
            GameOption(title: "Rest and watch from afar", nextSceneID: "gladeRest")
        ]
    ),
    
    "ancientTree": GameScene(
        id: "ancientTree",
        text: """
        You stand before the Worldroot.
        Its bark is etched with glowing runes, and a door seems to shimmer into view.
        """,
        options: [
            GameOption(title: "Enter the door", nextSceneID: "treeInterior"),
            GameOption(title: "Turn back while you can", nextSceneID: "forestEntrance")
        ]
    ),
    
    "gladeRest": GameScene(
        id: "gladeRest",
        text: """
        As you rest, the silver fox curls beside you.
        In your dreams, you glimpse the fate of kingdoms.
        When you awake, the forest feels changed.
        """,
        options: [
            GameOption(title: "Enter the Worldroot", nextSceneID: "treeInterior")
        ]
    ),
    
    "orbTouched": GameScene(
        id: "orbTouched",
        text: """
        As you touch the orb, visions flood your mind — a sleeping dragon, a lost crown, and a looming darkness.
        You are marked by ancient magic now.
        """,
        options: [
            GameOption(title: "Climb out of the well", nextSceneID: "deerTrail")
        ]
    ),
    
    "treeInterior": GameScene(
        id: "treeInterior",
        text: """
        Inside the Worldroot, endless stairways spiral in every direction.
        Somewhere deep within lies the key to your destiny.
        Fawn's true journey has just begun...
        """,
        options: [
            GameOption(title: "To be continued...", nextSceneID: "start") // Could loop, or end the game.
        ]
    )
]
