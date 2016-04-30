//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Atikur Rahman on 4/29/16.
//  Copyright © 2016 Atikur Rahman. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    // MAKR: -
    
    override func viewWillAppear(animated: Bool) {
        configureUI(recording: false)
    }
    
    // MARK: - Actions
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        configureUI(recording: true)
        recordAudio()
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        configureUI(recording: false)
        stopRecording()
    }
    
    // MARK: - Audio Recording
    
    func recordAudio() {
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: getAudioFilePath(), settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - Helpers
    
    func configureUI(recording recording: Bool) {
        recordButton.enabled = !recording
        stopButton.enabled = recording
        recordingLabel.text = recording ? "Recording in Progress" : "Tap to Record"
    }
    
    func getAudioFilePath() -> NSURL {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        return NSURL.fileURLWithPathComponents(pathArray)!
    }
}

