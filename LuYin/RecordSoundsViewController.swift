//
//  RecordSoundsViewController.swift
//  LuYin
//
//  Created by majun on 2017/5/7.
//  Copyright © 2017年 majun. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder:AVAudioRecorder!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stopRecordButtonClick(_ sender: Any) {
        setUIState(isRecording: false)
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
    }
    
    func setUIState(isRecording:Bool){
        recordButton.isEnabled = !isRecording
        stopRecordButton.isEnabled = isRecording
        tipLabel.text = isRecording ? "Start Recording" : "Tap to record"
    }
    
    @IBAction func recordButtonClick(_ sender: Any) {
        setUIState(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordName = "recordedVoice.wav"
        let pathArray = [dirPath,recordName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try!session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("record failed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recoudedAudioURL = sender as! URL
            playSoundVC.recordSoundsURL = recoudedAudioURL
        }
    }
    
}

