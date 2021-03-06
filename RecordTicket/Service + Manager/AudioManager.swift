//
//  AudioManager.swift
//  TestRecordAndPlay
//
//  Created by κΉμν on 2022/04/30.
//

import Foundation
import AVKit
import MediaPlayer

final class AudioManager: ObservableObject {
    
    var player: AVAudioPlayer?
    @Published private(set) var isLooping: Bool = false
    
    func startPlayer(fileName: String, title: String, image: UIImage) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fullURL = url.appendingPathComponent(fileName)
            
            player = try AVAudioPlayer(contentsOf: fullURL)
            player?.play()
            
            setupCommandCenter()
            remoteCommandInfoCenterSetting(title: title, image: image)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func setupCommandCenter() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "HIHI"]
        
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player?.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.player?.pause()
            return .success
        }
        commandCenter.seekForwardCommand.isEnabled = true
        commandCenter.seekBackwardCommand.isEnabled = true
    }
    
    func remoteCommandInfoCenterSetting(title: String, image: UIImage) {
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: CGSize(width: 250, height: 250), requestHandler: { _ in
            return image
        })
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfo[MPMediaItemPropertyArtist] = "Re cital"
        // μ½νμΈ  μ΄ κΈΈμ΄
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.duration
        // μ½νμΈ  μ¬μ μκ°μ λ°λ₯Έ progressBar μ΄κΈ°ν
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate
        // μ½νμΈ  νμ¬ μ¬μμκ°
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime
        
        center.nowPlayingInfo = nowPlayingInfo
        
//        if let albumCoverPage = UIImage(named: "Pingu") {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: albumCoverPage.size, requestHandler: { size in return albumCoverPage })
//        }
    }
        
        func playPause() {
            guard let player = player else {
                print("Instance of audio player not found")
                return
            }
            
            if player.isPlaying {
                player.pause()
            } else {
                player.play()
            }
        }
        
        func stop() {
            guard let player = player else { return }
            
            if player.isPlaying {
                player.stop()
            }
        }
        
        func toggleLoop() {
            guard let player = player else { return }
            // -1 -> λ¬΄ν λ£¨ν. 0λ§ μλλ©΄ true
            player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
            isLooping = player.numberOfLoops != 0
        }
    }
    
