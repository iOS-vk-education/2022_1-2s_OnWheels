//
//  EventsTableAdapter.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import UIKit

final class EventsTableAdapter: NSObject {
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, RaceInfo>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, RaceInfo>
    typealias EventAction = (Int) -> Void
    
    private var openAction: EventAction?
    private var likeAction: EventAction?
    private var dislikeAction: EventAction?
    
    private let tableView: UITableView
    private lazy var dataSource: DataSource = makeDataSource()
    
    private var racesInfo: [RaceInfo] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
}

extension EventsTableAdapter {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueCell(cellType: EventsInfoCell.self, for: indexPath)
            
            cell.selectionStyle = .none
            
            cell.configure(mainText: item.title,
                           dateText: item.dateSubtitle,
                           imageName: item.imageId,
                           likesNumber: item.numberOfLikes,
                           participantsNumber: item.numberOfParticipants,
                           viewsNumber: item.numberOfWatchers,
                           isLiked: item.isLiked)
            
            if item.isLiked {
                cell.setDislikeAction {
                    self.dislikeAction?(indexPath.row)
                }
            } else {
                cell.setLikeAction {
                    self.likeAction?(indexPath.row)
                }
            }
            
            return cell
        }
        
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(racesInfo, toSection: .main)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension EventsTableAdapter {
    func setOpenAction(_ action: @escaping EventAction){
        self.openAction = action
    }
    
    func setLikeAction(_ action: @escaping EventAction){
        self.likeAction = action
    }
    
    func setDislikeAction(_ action: @escaping EventAction){
        self.dislikeAction = action
    }
}

extension EventsTableAdapter {
    func update(with racesInfo: [RaceInfo]) {
        self.racesInfo = racesInfo
        applySnapshot()
    }
    
    func updateWithLike(withIndex index: Int) {
        racesInfo[index].isLiked = true
        racesInfo[index].numberOfLikes += 1
        applySnapshot()
    }
    
    func updateWithDislike(withIndex index: Int) {
        racesInfo[index].isLiked = false
        racesInfo[index].numberOfLikes -= 1
        applySnapshot()
    }
    
    func updateWatchers(withIndex index: Int) {
        racesInfo[index].numberOfWatchers += 1
        applySnapshot()
    }
    
    func updateParticipants(withIndex index: Int) {
        racesInfo[index].numberOfParticipants += 1
        applySnapshot()
    }
}


extension EventsTableAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 390
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openAction?(indexPath.row)
    }
}
