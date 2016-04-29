//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Atikur Rahman on 4/29/16.
//  Copyright © 2016 Atikur Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    
    // MAKR: -
    
    override func viewWillAppear(animated: Bool) {
        configureUI(recording: false)
    }
    
    // MARK: - Actions
    
    @IBAction func recordButtonPressed(sender: UIButton) {
        configureUI(recording: true)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        configureUI(recording: false)
    }
    
    // MARK: - Helpers
    
    func configureUI(recording recording: Bool) {
        recordButton.enabled = !recording
        stopButton.enabled = recording
        recordingLabel.text = recording ? "Recording in Progress" : "Tap to Record"
    }

}

