//
//  PicturesList.swift
//  numb1
//
//  Created by Adele Fatkullina on 18.10.2020.
//  Copyright © 2020 Adele Fatkullina. All rights reserved.
//

import UIKit

class PicturesList: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
     */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath)
        let str = "https://placehold.it/375x150?text=\(indexPath.row + 1)"
        
        cell.imageView?.downloadImage(from: URL(string: str)!, forCell: cell)
     
        return cell
    }
    
//Работает фигово, использовать не стала
    func downloadImage(withURL url: URL, forCell cell: UITableViewCell) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let data = data, let image = UIImage(data: data) {
                   //любые опреации, связанные с интерфейсом дб в главном потоке
                   DispatchQueue.main.async {
                    cell.imageView?.image = image
                   }
                
               }
           }.resume()
       }

}

let imageCache = NSCache<NSString, UIImage>()
let defImg = UIImage(named: "image-not-available")

extension UIImageView {

    func downloadImage(from imgURL: URL, forCell cell: UITableViewCell) {
        let url = URLRequest(url: imgURL)

        //устанавливаем начальное изображение nil, чтобы оно не использовало изображение из повторно используемой ячейки
        image = nil

        // уже в кэше
        if let imageToCache = imageCache.object(forKey: "\(imgURL)" as NSString) {
            self.image = imageToCache
            cell.imageView?.image = self.image ?? defImg!
        }

        // асинхронная скачка и кэширование
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                // создали UIImage
                let imageToCache = UIImage(data: data!)
                // добавили в кэш
                imageCache.setObject(imageToCache!, forKey: "\(imgURL)" as NSString)
                self.image = imageToCache
            }
        }
        task.resume()
        cell.imageView?.image = self.image ?? defImg!
    }
    
}
