//
//  PlayerViewController.swift
//  MyMusicPlayer
//
//  Created by Dipanwita Bardhan on 13/06/21.
//

import UIKit
import AVFoundation
class PlayerViewController: UIViewController {
    @IBOutlet weak var holder : UIView!
    public var position :Int = 0
    public var songArray : [Songs] = []
    let playPauseBtn = UIButton()
    private let albumImage : UIImageView = {
        let imageview  = UIImageView()
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    private let songName : UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let albumName : UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        return label
    }()
    private let artistName : UILabel = {
        let label  = UILabel()
        label.textAlignment = .center
        return label
    }()
    var player : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if holder.subviews.count == 0{
            configure()
        }
        // Do any additional setup after loading the view.
    }
    
    func configure()  {
        let song  = songArray[position]
        let url = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do{
           try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let url = url else {
                return
            }
            player = try AVAudioPlayer(contentsOf: URL(string: url)!)
            guard let player = player else {
                return
            }
            player.play()
        }
        catch{
            print(error.localizedDescription)
        }
        albumImage.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width - 20, height: holder.frame.size.width - 20)
        albumImage.image = UIImage(named: song.imageName)
        holder.addSubview(albumImage)
        //label
        songName.frame = CGRect(x: 10, y: albumImage.frame.size.height + 10, width: holder.frame.size.width - 20, height: 70)
        songName.text = song.name
        songName.textColor = .black
        
        albumName.frame = CGRect(x: 10, y: albumImage.frame.size.height + 80, width: holder.frame.size.width - 20, height: 70)
        albumName.text = song.albumName
        albumName.textColor = .black
        artistName.frame = CGRect(x: 10, y: albumImage.frame.size.height + 150, width: holder.frame.size.width - 20, height: 70)
        artistName.text = song.artistName
        artistName.textColor = .black
        holder.addSubview(songName)
        holder.addSubview(albumName)
        holder.addSubview(artistName)
        
        //playercontrols
        
        let nextbutton = UIButton()
        let preButton = UIButton()
        //frame
        let yPosition = artistName.frame.origin.y + 70 + 10
        let size = 60
        playPauseBtn.frame = CGRect(x: (Int(holder.frame.size.width) - 80)/Int(2.0), y: Int(yPosition), width: size, height: size)
        nextbutton.frame = CGRect(x: Int(holder.frame.size.width) - 100, y: Int(yPosition), width: size, height: size)
        preButton.frame = CGRect(x: 20, y: Int(yPosition), width: size, height: size)
        //setup
        playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextbutton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        preButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        playPauseBtn.addTarget(self, action: #selector(playPauseActions(_:)), for: .touchUpInside)
        preButton.addTarget(self, action: #selector(preActions(_:)), for: .touchUpInside)
        nextbutton.addTarget(self, action: #selector(nextActions(_:)), for: .touchUpInside)
        playPauseBtn.tintColor = .black
        nextbutton.tintColor = .black
        preButton.tintColor = .black
        holder.addSubview(playPauseBtn)
        holder.addSubview(nextbutton)
        holder.addSubview(preButton)
        //slider
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height - 60, width: holder.frame.size.width - 40, height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(sliderActions(_:)), for: .valueChanged)
        holder.addSubview(slider)
    }
    @objc func sliderActions(_ slider:UISlider){
        let value = slider.value
        player?.volume = value
    }
    @objc func playPauseActions(_ slider:UISlider){
       
    }
    @objc func nextActions(_ slider:UISlider){
        if position < songArray.count - 1{
            position = position + 1
            player?.stop()
            for sub in holder.subviews{
                sub.removeFromSuperview()
            }
            configure()
        }
    }
    @objc func preActions(_ slider:UISlider){
        if position > 0{
            position = position - 1
            player?.stop()
            for subv in holder.subviews{
                subv.removeFromSuperview()
            }
            configure()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let player = player{
            player.stop()
        }
    }
}
