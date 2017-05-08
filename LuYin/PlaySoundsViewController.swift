//
//  PlaySoundsViewController.swift
//  LuYin
//
//  Created by majun on 2017/5/7.
//  Copyright © 2017年 majun. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton:UIButton!
    @IBOutlet weak var fastButton:UIButton!
    @IBOutlet weak var highPitchButton:UIButton!
    @IBOutlet weak var lowPitchButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var stopButton:UIButton!

    var recordSoundsURL:URL!
    
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, highpitch, lowpitch, echo, reverb
    }
    
    @IBAction func playSoundButtonClick(_ sender:UIButton){
        switch (ButtonType(rawValue:sender.tag)!){
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highpitch:
            playSound(pitch: 1000)
        case .lowpitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb:true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopPlaySoundButtonClick(_ sender:UIButton){
        stopAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureUI(.notPlaying)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }

}
