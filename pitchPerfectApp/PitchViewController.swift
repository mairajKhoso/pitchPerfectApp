//
//  PitchViewController.swift
//  pitchPerfectApp
//
//  Created by Apple Macbook on 15/01/2019.
//  Copyright © 2019 Hivelet. All rights reserved.
//

import UIKit
import AVFoundation
class PitchViewController: UIViewController {
    var recordedAudioURL : URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode:AVAudioPlayerNode!
    var stopTimer:Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    @IBOutlet weak var fastBtn: UIButton!
    @IBOutlet weak var slowBtn: UIButton!
    @IBOutlet weak var lowPitchBtn: UIButton!
    @IBOutlet weak var highPitchBtn: UIButton!
    @IBOutlet weak var echoBtn: UIButton!
    @IBOutlet weak var reverbBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    @IBAction func playSoundForBtn(_sender: UIButton)
    {
        switch (ButtonType(rawValue: _sender.tag)!) {
        case .slow:
            playSound(rate:0.5)
        case .fast:
            playSound(rate:1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo:true)
        case .reverb:
            playSound(reverb:true)
        }
        configureUI(.playing)
    }
    @IBAction func stopSoundForBtn(_sender: UIButton){
        stopAudio()
    }



}
