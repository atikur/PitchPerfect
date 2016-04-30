//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Atikur Rahman on 4/29/16.
//  Copyright © 2016 Atikur Rahman. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    // MARK: - Properties
    
    static let identifierStopRecordingSegue = "stopRecording"

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    
    // MAKR: -
    
    override func viewWillAppear(animated: Bool) {
        configureUI(recording: false)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == RecordSoundsViewController.identifierStopRecordingSegue {
            let destinationVC = segue.destinationViewController as! PlaySoundsViewController
            destinationVC.recordedAudioURL = sender as! NSURL
        }
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
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func stopRecording() {
        audioRecorder.stop()
        
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    // MARK: - AVAudioRecorderDelegate Methods
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegueWithIdentifier(RecordSoundsViewController.identifierStopRecordingSegue, sender: audioRecorder.url)
        }
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

