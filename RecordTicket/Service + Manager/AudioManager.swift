//
//  AudioManager.swift
//  TestRecordAndPlay
//
//  Created by 김예훈 on 2022/04/30.
//

import Foundation
import AVKit
import MediaPlayer

final class AudioManager: ObservableObject {
    
    var player: AVAudioPlayer?
    @Published private(set) var isLooping: Bool = false
    
    func startPlayer(fileName: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fullURL = url.appendingPathComponent(fileName)
            
            player = try AVAudioPlayer(contentsOf: fullURL)
            player?.play()
            
            setupCommandCenter()
            remoteCommandInfoCenterSetting()
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
    
    func remoteCommandInfoCenterSetting() {
        let center = MPNowPlayingInfoCenter.default()
        var nowPlayingInfo = center.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "콘텐츠 제목"
        nowPlayingInfo[MPMediaItemPropertyArtist] = "콘텐츠 아티스트"
        // 콘텐츠 총 길이
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.duration
        // 콘텐츠 재생 시간에 따른 progressBar 초기화
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate
        // 콘텐츠 현재 재생시간
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
            // -1 -> 무한 루프. 0만 아니면 true
            player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
            isLooping = player.numberOfLoops != 0
        }
    }
    
