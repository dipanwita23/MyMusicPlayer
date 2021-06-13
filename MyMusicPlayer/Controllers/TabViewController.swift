//
//  TabViewController.swift
//  MyMusicPlayer
//
//  Created by Dipanwita Bardhan on 13/06/21.
//

import UIKit

class TabViewController:  UIViewController , UITableViewDataSource , UITableViewDelegate{
   
    //outlets
    @IBOutlet weak var tableVwPlaylist: UITableView!
    var song = [Songs]()
    var inx = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableVwPlaylist.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableVwPlaylist.delegate = self
        tableVwPlaylist.dataSource = self
        // Do any additional setup after loading the view.
    }
    //actions
    func configureSongs()  {
        if inx == 0{
        song.append(Songs(name: "Channa", albumName: "ADHM", artistName: "Arijit", imageName: "arijit", trackName: "arijit1"))
        song.append(Songs(name: "GHoomar", albumName: "Padmavat", artistName: "Shreya", imageName: "shreya", trackName: "shreya1"))
        song.append(Songs(name: "Aashiqui", albumName: "Jubin Hits", artistName: "Jubin", imageName: "jubin", trackName: "jubin"))
        }else{
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        let songArray = song[indexPath.row]
        cell.songName.text = songArray.name
        cell.detailsSong.text = songArray.albumName
        cell.artistImage.image = UIImage(named: songArray.imageName)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        let vc = storyboard?.instantiateViewController(identifier: "PlayerViewController")  as! PlayerViewController  
        vc.position = position
        vc.songArray = song
       present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

    
