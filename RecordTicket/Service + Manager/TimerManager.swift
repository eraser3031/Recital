//
//  TimerManager.swift
//  TestRecordAndPlay
//
//  Created by 김예훈 on 2022/05/01.
//

import SwiftUI

class TimerManager: ObservableObject {
    
    @Published var minutesString = "00"
    @Published var secondsString = "00"
    @Published var millisecondsString = "00"
    @Published var mode: stopWatchMode = .stopped
    
    var secondsElapsed = 0.0
    var completedSecondsElapsed = 0.0
    var timer = Timer()
    
    func start() {
        self.mode = .timing
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
        self.secondsElapsed += 0.01
        self.formatTime()
        }
    }
    
    func stop() {
        timer.invalidate()
        self.mode = .stopped
        self.completedSecondsElapsed = self.secondsElapsed
        self.secondsElapsed = 0.0
    }
    
    func pause() {
        timer.invalidate()
        self.mode = .paused
    }
    
    func formatTime() {
        let minutes: Int32 = Int32(self.secondsElapsed/60)
        let seconds: Int32 = Int32(self.secondsElapsed) - (minutes * 60)
        let milliseconds: Int32 = Int32(self.secondsElapsed.truncatingRemainder(dividingBy: 1) * 100)
        
        minutesString = (minutes < 10) ? "0\(minutes)" : "\(minutes)"
        secondsString = (seconds < 10) ? "0\(seconds)" : "\(seconds)"
        millisecondsString = (milliseconds < 10) ? "0\(milliseconds)" : "\(milliseconds)"
    }
}

enum stopWatchMode {
    case timing
    case stopped
    case paused
}
