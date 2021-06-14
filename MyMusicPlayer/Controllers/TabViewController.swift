//
//  TabViewController.swift
//  MyMusicPlayer
//
//  Created by Dipanwita Bardhan on 13/06/21.
//

import UIKit
import AVFoundation
class TabViewController:  UIViewController , UITableViewDataSource , UITableViewDelegate{
   
    //outlets
    @IBOutlet weak var tableVwPlaylist: UITableView!
   
    var song = [Songs]()
    var inx = 0
    var player : AVAudioPlayer?
    var isPlay = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableVwPlaylist.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableVwPlaylist.delegate = self
        tableVwPlaylist.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let player = player{
            player.stop()
        }
    }
    //actions
    func configureSongs()  {
        if inx == 0{
        player?.stop()
        song.append(Songs(name: "Channa", albumName: "ADHM", artistName: "Arijit", imageName: "arijit", trackName: "arijit1"))
        song.append(Songs(name: "GHoomar", albumName: "Padmavat", artistName: "Shreya", imageName: "shreya", trackName: "shreya1"))
        song.append(Songs(name: "Aashiqui", albumName: "Jubin Hits", artistName: "Jubin", imageName: "jubin", trackName: "jubin"))
        }else{
            player?.stop()
            song.append(Songs(name: "Bulleya", albumName: "ADHM", artistName: "Arijit", imageName: "arijit", trackName: "arijit2"))
            song.append(Songs(name: "Naino Wale", albumName: "Padmavat", artistName: "Shreya", imageName: "shreya", trackName: "shreya2"))
            song.append(Songs(name: "Peheli Dafa", albumName: "Atif", artistName: "Atif", imageName: "atif", trackName: "atif"))
        }
    }
    
    //Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        player?.stop()
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let songArray = song[indexPath.row]
        cell.songName.text = songArray.name
        cell.detailsSong.text = songArray.albumName
        cell.artistImage.image = UIImage(named: songArray.imageName)
        cell.accessoryType = .disclosureIndicator
        cell.playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        cell.playPauseBtn.tintColor = .white
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configure(position : indexPath.row)
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        if isPlay != false {
            isPlay = false
            player?.pause()
            player?.volume = 0.5
            cell.playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }else{
            isPlay = true
            player?.play()
            player?.volume = 0.5
            cell.playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
        
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func configure(position : Int )  {
        let song  = song[position]
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
    
        
        //playercontrols
        
   
    }
    
    
}

    
