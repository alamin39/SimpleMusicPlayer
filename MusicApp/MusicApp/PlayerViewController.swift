//
//  ViewController.swift
//  MusicApp
//
//  Created by Al-Amin on 3/3/21.
//  Copyright © 2021 Al-Amin. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var previousTrack: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var nextTrack: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var imageViewLeadingCons: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingCons: NSLayoutConstraint!

    var songs = [Song]()
    var songNum = 0
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        let song = songs[songNum]
        imageView.image = UIImage(named: song.imageName)
        songName.text = song.name
        albumName.text = song.albumName
        trackName.text = song.trackName
        pause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        UIView.animate(withDuration: 0.2) {
            self.imageViewLeadingCons.constant = 10
            self.imageViewTrailingCons.constant = 10
        }

        let url = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            player = try AVAudioPlayer(contentsOf: URL(string: url!)!)
        } catch {
            print(error)
        }
        player?.play()
    }


    @IBAction func previousTrackPressed(_ sender: Any) {
        if songNum > 0 {
            songNum -= 1
            configureUI()
        }
        else {
            print("Go forward!")
        }
    }


    @IBAction func pauseTrackPressed(_ sender: Any) {
        if player!.isPlaying {
            player?.pause()
            pause.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.imageViewLeadingCons.constant = 20
                self.imageViewTrailingCons.constant = 20
            }
        }
        else {
            player?.play()
            pause.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            UIView.animate(withDuration: 0.2) {
                self.imageViewLeadingCons.constant = 10
                self.imageViewTrailingCons.constant = 10
            }
        }
    }


    @IBAction func nextTrackPressed(_ sender: Any) {
        if songNum < (songs.count - 1) {
            songNum += 1
            configureUI()
        }
        else {
            print("Go backward!")
        }
    }


    @IBAction func volumeSliding(_ sender: Any) {
        player?.volume = volumeSlider.value
    }
}
