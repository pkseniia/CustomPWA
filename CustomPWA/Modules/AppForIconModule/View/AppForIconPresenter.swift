//
//  AppForIconPresenter.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 08.11.2020.
//

import Foundation

protocol AppForIconPresenterProtocol: BasePresenterProtocol {
    var dataSourceCount: Int { get }
    func getObject(_ index: Int) -> CellObjectConfigurable?
    func pushSelectAppScreen()
    func createApp()
}

class AppForIconPresenter<View: AppForIconViewProtocol>: BasePresenter<View> {
    
    private let coordinator: CoordinatorProtocol
    private let servicesContainer: ServicesContainerProtocol
    private let getImageForAppUseCase: GetImageForAppUseCaseProtocol
    private let createAppEntityUseCase: CreateAppEntityUseCaseProtocol
    
    private var dataSource: [IconForAppCellObjectProtocol] = []
    
    init(view: View,
         coordinator: CoordinatorProtocol,
         servicesContainer: ServicesContainerProtocol,
         getImageForAppUseCase: GetImageForAppUseCaseProtocol,
         createAppEntityUseCase: CreateAppEntityUseCaseProtocol) {
        self.coordinator = coordinator
        self.servicesContainer = servicesContainer
        self.getImageForAppUseCase = getImageForAppUseCase
        self.createAppEntityUseCase = createAppEntityUseCase
        super.init(view: view)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = getImageForAppUseCase.getImage()
        view.setImage(with: image)
        createAppEntityUseCase.setCustomImage(image: image)
        fillDataSource()
    }
    
    private func fillDataSource(entity: CustomAppEntity? = nil) {
        let appTitle = entity?.originalTitle ?? Constants.AppForIcon.chooseApplication
        let appImage = entity?.originalImage ?? .custom(name: .appleApp)
        let userTitle = entity?.title ?? Constants.AppForIcon.enterNameForApp
        dataSource = [
            AppIconTableViewCellObject(cellTitle: appTitle,
                                       cellImage: appImage),
            AppNameTableViewCellObject(cellTitle: userTitle,
                                       textFieldAction: { [weak self] newName in
                                        guard let self = self else { return }
                                        self.updateName(with: newName)
                                       })
        ]
        view.reloadTableView()
    }
    
    private func updateName(with name: String?) {
        createAppEntityUseCase.setName(name: name)
        view.enableCreateAppButton(with: createAppEntityUseCase.checkIfEntityIsReady())
    }
    
    private func setSchema(with entity: ExternalAppEntity) {
        createAppEntityUseCase.set(originalTitle: entity.name?.name, originalImage: entity.image, schema: entity.schema)
        fillDataSource(entity: createAppEntityUseCase.getCurrentEntity())
        view.enableCreateAppButton(with: createAppEntityUseCase.checkIfEntityIsReady())
    }
}

extension AppForIconPresenter: AppForIconPresenterProtocol {

    var dataSourceCount: Int { return dataSource.count }
    
    func getObject(_ index: Int) -> CellObjectConfigurable? {
        guard let object = dataSource[index] as? CellObjectConfigurable else { return nil}
        return object
    }
    
    func pushSelectAppScreen() {
        coordinator.pushAppsListViewController(servicesContainer: servicesContainer,
                                               selectCallBack: { [weak self] selectedApp in self?.setSchema(with: selectedApp) })
    }
    
    func createApp() {
        print("createApp")
    }
}

