//
//  APICallURLSessionViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 23/02/21.
//  Description: Call given API to fetch Author details and display in Collection View.

import UIKit

class APICallURLSessionViewController: UIViewController {
    
    @IBOutlet weak var feedTitleLbl: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    
    let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
    
    private var displayDetails = [Result]()
    private var feedTitle: String = ""
    private var sectionTitleArr: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside viewDidLoad")
        fetchDataFromURL()
        selfDelegateSetting()
    }
    
    func selfDelegateSetting() {
        dataTableView.dataSource = self
        dataTableView.delegate = self
    }
    
    func fetchDataFromURL() {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default)
            let sessionTask = urlSession.dataTask(with: url) { (data, response, urlerror) in
                if let safeData = data, response != nil, urlerror == nil {
                    print("Started fetching data")
                    do {
                        let decoder = JSONDecoder()
                        let rootData = try decoder.decode(Root.self, from: safeData)
                        self.displayDetails = rootData.feed.results
                        print(self.displayDetails[1].artistName)
                        print(rootData.feed.title)
                        self.feedTitle = rootData.feed.title
                        print(self.feedTitle)
                        DispatchQueue.main.async {
                            print("Just before reloadData")
                            self.dataTableView.reloadData()
                            self.feedTitleLbl.text = self.feedTitle
                        }
                        
                    } catch {
                        print("Something went wrong \(error)")
                    }
                }
            }
            sessionTask.resume()
            
        }
    }
}

//MARK: - UITableViewDataSource

extension APICallURLSessionViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("Inside numberOfSections")
        //        return sectionTitleArr.count
        return 2
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        print("Inside sectionIndexTitles")
        return sectionTitleArr
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataCell = dataTableView.dequeueReusableCell(withIdentifier: StoryboardIdentifier.callAPICellIdentifier) as? UrlSessionTableViewCell else { return UITableViewCell() }
        
        DispatchQueue.main.async { [self] in
            dataCell.nameLbl.text = displayDetails[indexPath.row].name
            dataCell.IDLbl.text = "ID: " + displayDetails[indexPath.row].id
            dataCell.artistNameLbl.text = displayDetails[indexPath.row].artistName
            dataCell.artistIDLbl.text = "ArtistID: " + displayDetails[indexPath.row].id
            dataCell.releaseDateLbl.text = "Release Date: " + displayDetails[indexPath.row].releaseDate
            dataCell.copyrightLbl.text = "copyright - " + displayDetails[indexPath.row].copyright
        }
        
        if let artistImageURL = URL(string: displayDetails[indexPath.row].artworkUrl100) {
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: artistImageURL)
                if let safeImageData = imageData {
                    let artistImage = UIImage(data: safeImageData)
                    DispatchQueue.main.async {
                        dataCell.dataImageView.image =  artistImage
                    }
                }
            }
        }
        return dataCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        print("Inside titleForHeaderInSection")
        return "Music List - "
    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //        print("Inside titleForFooterInSection")
    //        return "by Prachi Bile"
    //    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        print("inside canEditRowAt")
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        print("Inside canMoveRowAt")
        return true
    }
}

//MARK: - UITableViewDelegate

extension APICallURLSessionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("Inside heightForRowAt")
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print("Inside heightForHeaderInSection")
        return 50
    }
    
    //    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    //        print("Inside estimatedHeightForRowAt")
    //        return 130.50
    //    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Inside UITableViewDelegate: willDisplay")
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        print("Inside UITableViewDelegate: willDisplayHeaderView")
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.5294117647, alpha: 1)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = #colorLiteral(red: 0.9764705882, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        print("Inside UITableViewDelegate: willDisplayFooterView")
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Inside UITableViewDelegate: didEndDisplaying")
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        print("Inside shouldHighlightRowAt")
        return true
    }
    
    //    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    //        return
    //    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        print("Inside shouldShowMenuForRowAt")
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Inside didSelectRowAt")
        print(displayDetails[indexPath.row].artistUrl)
        // On click on tableView Cell redirect to artistURL String
        if let artistURL = URL(string: displayDetails[indexPath.row].artistUrl) {
            UIApplication.shared.open(artistURL)
        }
    }
}


//MARK: - UITableViewDataSourcePrefetching

extension APICallURLSessionViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("Inside prefetchRowsAt")
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Inside cancelPrefetchingForRowsAt")
    }
    
}

//MARK: - UITableViewDragDelegate

//extension APICallURLSessionViewController: UITableViewDragDelegate {
//    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
//        print("Inside UITableViewDragDelegate")
//    }
//
//
//}

//MARK: - UITableViewDropDelegate

extension APICallURLSessionViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("Inside UITableViewDropDelegate")
    }
    
}
