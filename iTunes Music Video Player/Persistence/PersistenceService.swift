//
//  PersistenceService.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import UIKit
import CoreData

protocol QueryResultService {
    func fetchQueryResults(completition: @escaping (Result<[QueryResultViewModel], PersistenceError>) -> Void)
    func saveQueryResult(searchTerm: String, musicVideosViewModel: [MusicVideoViewModel])
}

class PersistenceService: NSObject {
    private let entity: String = "SearchQuery"
    private var managedContext: NSManagedObjectContext?
    
    override init() {
        super.init()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        self.managedContext = appDelegate.persistentContainer.viewContext
    }
    
    fileprivate func processResponse(queryResponse: [NSManagedObject]) -> Result<[QueryResultViewModel], PersistenceError> {
        
        guard let searchQueries = queryResponse as? [SearchQuery] else {return .failure(.notFoundEntity)}
        
        var queryResults = [QueryResultViewModel]()
        
        for searchQuery in searchQueries {
            guard let sresult = searchQuery.results, let searchQueryText = searchQuery.searchQueryText else { return .failure(.parsingError)}
            
            var musicVideosViewModel = [MusicVideoViewModel]()
            for searchMusicVideo in sresult {
                guard let smusicVideo = searchMusicVideo as? MusicvideoQuery, let artistName = smusicVideo.artistName, let songTitle = smusicVideo.title else { return .failure(.parsingError)}
                
                let musicVideo = MusicVideo(artistName: artistName, trackCensoredName: songTitle, artworkUrl100: nil, previewUrl: nil)
                let musicVideoVM = MusicVideoViewModel(musicVideo: musicVideo)
                
                musicVideosViewModel.append(musicVideoVM)
            }
            
            let queryResult = QueryResult(queryString: searchQueryText, musicVideoViewModels: musicVideosViewModel)
            
            let queryResultViewModel = QueryResultViewModel(queryResult: queryResult)
            
            queryResults.append(queryResultViewModel)
        }
        
        
        return .success(queryResults)
    }
    
    private func submit(completition: @escaping (Result<[QueryResultViewModel], PersistenceError>) -> Void) {
        let fetchRequest = NSFetchRequest<SearchQuery>(entityName: entity)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                guard let sself = self, let smanagedContext = sself.managedContext else { return }
                let result = try smanagedContext.fetch(fetchRequest)
                completition((sself.processResponse(queryResponse: result)))
            } catch {
                completition(.failure(.notFoundEntity))
            }
        }
    }
    
    private func save(searchTerm: String, musicVideosViewModel: [MusicVideoViewModel]) {
        guard let smanagedContext = managedContext else { return }
        let query = SearchQuery(context: smanagedContext)
        
        query.searchQueryText = searchTerm
        var musicVideos = [MusicvideoQuery]()
        
        for musicVideo in musicVideosViewModel {
            let mv = MusicvideoQuery(context: smanagedContext)
            mv.artistName = musicVideo.artistName
            mv.title = musicVideo.title
            mv.previewUrl = musicVideo.previewUrl
            
            musicVideos.append(mv)
        }
        
        query.results = NSOrderedSet.init(array: musicVideos)
        
        DispatchQueue.global(qos: .utility).async {
            do {
                try smanagedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    
    
}

extension PersistenceService: QueryResultService {
    func saveQueryResult(searchTerm: String, musicVideosViewModel: [MusicVideoViewModel]) {
        save(searchTerm: searchTerm, musicVideosViewModel: musicVideosViewModel)
    }
    
    func fetchQueryResults(completition: @escaping (Result<[QueryResultViewModel], PersistenceError>) -> Void) {
        submit(completition: completition)
    }
}
