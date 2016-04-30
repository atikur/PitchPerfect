//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Atikur Rahman on 4/30/16.
//  Copyright © 2016 Atikur Rahman. All rights reserved.
//

import UIKit

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet var soundEffectButtons: [UIButton]!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setContentModeForButtons()
    }
    
    // MARK: - Helpers
    
    func setContentModeForButtons() {
        for button in soundEffectButtons {
            button.imageView?.contentMode = .ScaleAspectFit
        }
        
        stopButton.imageView?.contentMode = .ScaleAspectFit
    }
}
