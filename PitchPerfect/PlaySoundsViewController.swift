//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Atikur Rahman on 4/30/16.
//  Copyright © 2016 Atikur Rahman. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    enum SoundEffect: Int {
        case Snail = 0, Rabbit, Chipmunk, DarthVader, Echo, Reverb
    }
    
    @IBOutlet var soundEffectButtons: [UIButton]!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        
        setContentModeForButtons()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.NotPlaying)
    }
    
    // MARK: - Actions
    
    @IBAction func playSoundForButton(sender: UIButton) {
        guard let soundEffect = SoundEffect(rawValue: sender.tag) else {
            return
        }
        
        switch soundEffect {
        case .Snail:
            playSound(rate: 0.5)
        case .Rabbit:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .DarthVader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        stopAudio()
    }
    
    // MARK: - Helpers
    
    func setContentModeForButtons() {
        for button in soundEffectButtons {
            button.imageView?.contentMode = .ScaleAspectFit
        }
        
        stopButton.imageView?.contentMode = .ScaleAspectFit
    }
}
