//
//  SoundPlayer.swift
//  5StarAutoDirect
//
//  Created by Michael Castillo on 8/9/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    
    enum Sound: String {
        case ferrari = "Ferrari"
        
        var url: URL? {
            switch self {
            case .ferrari:
                guard let path = Bundle.main.path(forResource: "Ferrari", ofType: "m4a") else { return nil }
                return URL(fileURLWithPath: path)
            }
        }
        
    }
    
    var sound: Sound
    
    fileprivate var player: AVAudioPlayer? {
        guard let url = sound.url else { return nil }
        return try? AVAudioPlayer(contentsOf: url)
    }
    
    init(sound: Sound) {
        self.sound = sound
    }
    
    func play() {
        player?.prepareToPlay()
        player?.play()
    }
    
    func prepare() {
        player?.prepareToPlay()
    }
    
}
