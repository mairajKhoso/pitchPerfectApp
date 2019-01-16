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

    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var RecordingLbl: UILabel!
    @IBOutlet weak var recordBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RecordingLbl.text = "Tap to record"
        recordBtn.isEnabled = true
        stopBtn.isEnabled = false
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
        }

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
        
        
//        var url = NSURL.fileURLWithPath(str as String)

        let fulFilePath = dirPath + "/" + "recordedVoice.wav"
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath , recordingName]
        let filePath = URL(fileURLWithPath: fulFilePath)
        //print(filePath)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, mode: .default, options: [])
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//        } catch {
//            print(error)
//        }
        self.startRecording()
//        audioRecord = AVAudioRecorder(url: getFileUrl(), settings: [:])
        audioRecorder.delegate = self
//        audioRecord.isMeteringEnabled = true
//        audioRecord.prepareToRecord()
//        audioRecord.record()
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
        }
    }
    


    @IBAction func StopBtnTapped(_ sender: UIButton) {
        recordBtn.isEnabled = true
        stopBtn.isEnabled = false
        RecordingLbl.text = "Recording stopped"
        // stop the recording
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
        print("recording was not succesful")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let playSoundVC = segue.destination as! PitchViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }

}

