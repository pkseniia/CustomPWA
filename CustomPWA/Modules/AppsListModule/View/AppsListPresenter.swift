//
//  AppsListPresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import UIKit

typealias SelectAppCallBack = (ExternalAppEntity) -> Void

protocol AppsListPresenterProtocol: BasePresenterProtocol {
    var dataSourceCount: Int { get }
    func getObject(_ index: Int) -> CellObjectConfigurable?
    func selectItem(_ index: Int)
}

class AppsListPresenter<View: AppsListViewProtocol>: BasePresenter<View> {
    
    private let coordinator: CoordinatorProtocol
    private let servicesContainer: ServicesContainerProtocol
    
    private var apps: [ExternalAppEntity] = []
    private var dataSource: [IconForAppCellObjectProtocol] = []
    
    private var selectAppAction: SelectAppCallBack?
    
    init(view: View,
         coordinator: CoordinatorProtocol,
         servicesContainer: ServicesContainerProtocol,
         selectCallBack: @escaping SelectAppCallBack) {
        self.coordinator = coordinator
        self.servicesContainer = servicesContainer
        self.selectAppAction = selectCallBack
        super.init(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillDataSource()
    }
    
    private func fillDataSource() {
        getAppsOnDevice()
        fetchImages { [weak self] in self?.appendToDataSource() }
    }
    
    private func getAppsOnDevice() {
        guard let asset = NSDataAsset(name: "Apps") else { return }
        guard let externalApps = try? PropertyListDecoder().decode([ExternalAppEntity].self, from: asset.data) else { return }
        let internalApps = externalApps.filter({
            guard let url = URL(string: $0.schema) else { return false }
            return UIApplication.shared.canOpenURL(url)
        })
        apps = internalApps
    }
    
    private func fetchImages(completion: @escaping EmptyBlock) {
        if servicesContainer.isHostReachable {
            let group = DispatchGroup()
            let serialQueue = DispatchQueue(label: "serialQueue")
            apps.forEach({ app in
                group.enter()
                self.servicesContainer.getImageForApp(by: app.appStoreId) { image in
                    switch image {
                    case .none: group.leave()
                    case .some(let image):
                        serialQueue.async {
                            app.image = image
                            group.leave()
                        }
                    }
                }
            })
            group.notify(queue: .main) {
                completion()
            }
        } else {
            view.processError(message: Constants.Errors.noInternetConnection,
                              completion: { _ in completion() })
        }
    }
    
    private func appendToDataSource() {
        apps.forEach({
            guard let name = $0.name?.name, let image = $0.image else { return }
            dataSource.append(AppIconTableViewCellObject(cellTitle: name, cellImage: image, arrowImageHidden: true))
        })
        DispatchQueue.main.async { [weak self] in self?.view.reloadTableView() }
    }
}

extension AppsListPresenter: AppsListPresenterProtocol {

    var dataSourceCount: Int { return dataSource.count }
    
    func getObject(_ index: Int) -> CellObjectConfigurable? {
        guard let object = dataSource[index] as? CellObjectConfigurable else { return nil}
        return object
    }
    
    func selectItem(_ index: Int) {
        let selectedApp = apps[index]
        selectAppAction?(selectedApp)
        coordinator.pop(servicesContainer: servicesContainer)
    }
}
