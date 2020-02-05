//
//  ThirdViewController.swift
//  RecipeLearner
//
//  Created by Varun Narayanswamy on 2/3/20.
//  Copyright © 2020 Varun Narayanswamy. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    let audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    let filename = "audio.m4a"

    @IBOutlet weak var RecordButton: UIButton!
    @IBOutlet weak var StopButton: UIButton!
    @IBOutlet weak var PlayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PlayButton.isEnabled = false
        StopButton.isEnabled = false
        
        //get path for the audio file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        let audioFileURL = docDir.appendingPathComponent(filename)
        print(audioFileURL)
        
        
        
        //configure our audioSession
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .init(rawValue: 1))
        } catch {
            print("audio session error: \(error.localizedDescription)")
        }
        
        //declare our settings in a dictionary
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), // audio codec
            AVSampleRateKey: 1200, //sample rate in hZ
            AVNumberOfChannelsKey: 1, //num of channels
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue // audio bit rate
        ]
        
        do  {
            //create our recorder instance
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: settings)
            //get it ready for recording by creating the audio file at the specified location
            audioRecorder?.prepareToRecord()
            print("Audio recorder ready!")
        } catch {
            print("Audio recorder error: \(error.localizedDescription)")
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Record(_ sender: Any) {
        if let recorder = audioRecorder {
            //check to make sure we aren't already recording
            if recorder.isRecording == false {
                //enable the stop button and start recording
                PlayButton.isEnabled = false
                StopButton.isEnabled = true
                recorder.delegate = self //allows recorder to respond to errors and complete the recording
                recorder.record()
            }
        } else {
            print("No audio recorder instance")
        }
    }
    @IBAction func Play(_ sender: Any) {
        if audioRecorder?.isRecording == false {
            StopButton.isEnabled = true
            RecordButton.isEnabled = false
            
            do {
                try audioPlayer = AVAudioPlayer(contentsOf: (audioRecorder?.url)!)
                //set to playback mode for optimal volume
                try audioSession.setCategory(AVAudioSession.Category.playback)
                audioPlayer!.delegate = self
                audioPlayer!.prepareToPlay() // preload audio
                audioPlayer!.play() //plays audio file
            } catch {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
    @IBAction func Stop(_ sender: Any) {
        StopButton.isEnabled = false
        PlayButton.isEnabled = true
        RecordButton.isEnabled = true
        
        //stop recording if that's the current task
        if audioRecorder?.isRecording == true {
            audioRecorder?.stop()
        } else { // stop the playback and reset the audio session mode
            audioPlayer?.stop()
            //reset session mode
            do {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        RecordButton.isEnabled = true
        StopButton.isEnabled = false
        //reset av session mode to optimize recording
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
