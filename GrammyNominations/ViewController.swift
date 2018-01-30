//
//  ViewController.swift
//  GrammyNominations
//
//  Created by Richard Crichlow on 1/30/18.
//  Copyright © 2018 Richard Crichlow. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var artistNameTextField: UITextField!
    
    @IBOutlet weak var artistAlbumTextField: UITextField!
    
    var artistList = [GrammyArtist]()
    
    
    @IBAction func addArtistButton(_ sender: UIButton) {
        
        // Prevents empty string posts. Textfields are never actually nil, just empty strings
        guard artistNameTextField.text != "" else {return}
        guard artistAlbumTextField.text != "" else {return}
        
        // This gives each post an ID
        // You can associate a UID with their post ID's this way
        let key = refArtists.childByAutoId().key
        
        // This is how the dictinary will appear in your database
        let artist = ["id":key, "artistName": artistNameTextField.text! as String, "artistAlbum": artistAlbumTextField.text! as String]
        
        // This sets the values
        refArtists.child(key).setValue(artist)
        
        // This updates the label
        resposeLabel.text = "Artist Added"
        
    }
    
    @IBOutlet weak var resposeLabel: UILabel!
    
    // Identifier is "cell"
    @IBOutlet weak var tableView: UITableView!
    
    var refArtists: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This will MAKE the reference if it doesn't exist
        refArtists = Database.database().reference().child("artists")
        
        // This will repopulate and refresh the tableview
        refArtists.observe(DataEventType.value) { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.artistList.removeAll()
                
                // This loop turns the dictionary into an array of the Custom Object
                for artists in snapshot.children.allObjects as! [DataSnapshot] {
                    
                    let artistObject = artists.value as? [String: AnyObject]
                    
                    let artistName = artistObject?["artistName"] as! String
                    let artistID = artistObject?["id"] as! String
                    let artistAlbum = artistObject?["artistAlbum"] as! String
                    
                    let artist = GrammyArtist(id: artistID, name: artistName, album: artistAlbum)
                    
                    self.artistList.append(artist)
                    
                }
                self.tableView.reloadData()
            }
        }
        
    }

    


}
extension ViewController: UITableViewDelegate {
    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GrammyTableViewCell
        
        let artist: GrammyArtist
        
        artist = artistList[indexPath.row]
        
        cell.nameLabel.text = artist.name
        cell.albumLabel.text = artist.album
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
}
