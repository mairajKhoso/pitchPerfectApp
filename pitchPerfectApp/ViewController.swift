//
//  ViewController.swift
//  pitchPerfectApp
//
//  Created by Apple Macbook on 15/01/2019.
//  Copyright © 2019 Hivelet. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, AVAudioRecorderDelegate {

    
    var audioRecord = AVAudioRecorder()
    @IBOutlet weak var RecordingLbl: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RecordingLbl.text = "Tap to record"
        recordBtn.isEnabled = true
        stopBtn.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear called")
    }
    @IBAction func RecordBtnTapped(_ sender: UIButton) {
        recordBtn.isEnabled = false
        stopBtn.isEnabled = true
        RecordingLbl.text = "Recording in progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath , recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        try! audioRecord = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecord.isMeteringEnabled = true
        audioRecord.prepareToRecord()
        audioRecord.record()
    }
    
    @IBAction func StopBtnTapped(_ sender: UIButton) {
        recordBtn.isEnabled = true
        stopBtn.isEnabled = false
        RecordingLbl.text = "Recording stopped"
        // stop the recording
        audioRecord.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

