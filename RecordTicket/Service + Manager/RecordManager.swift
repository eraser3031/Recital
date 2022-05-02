//
//  RecordManage.swift
//  TestRecordAndPlay
//
//  Created by 김예훈 on 2022/05/02.
//

import Foundation
import AVKit

final class RecordManager: ObservableObject {
    var recorder: AVAudioRecorder!
    var recordURL: URL?
    
    let settings = [
        AVFormatIDKey : Int(kAudioFormatAppleLossless),
        AVSampleRateKey: 44100,
        AVNumberOfChannelsKey : 2,
        AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue
    ]

    func start() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let filName = url.appendingPathComponent("Recital_.m4a")
        self.recordURL = filName
        
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord)
            recorder = try AVAudioRecorder(url: filName, settings: self.settings)
            recorder.record()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stop() {
        recorder?.stop()
    }
}

