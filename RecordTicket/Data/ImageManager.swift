//
//  ImageManager.swift
//  RecordTicket
//
//  Created by 김예훈 on 2022/05/05.
//

import Foundation
import UIKit

class ImageManager {
    
    static let instance = ImageManager()
    
    private init() { }
    
    func saveImage(uiImage: UIImage) -> String {
        let imageData = uiImage.jpegData(compressionQuality: 0.5)
        guard let imageData = imageData else { return "" }
        
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let filName = "\(UUID().uuidString).jpeg"
        let filePath = url.appendingPathComponent(filName)
        
        do {
            try imageData.write(to: filePath)
        } catch {
            print(error.localizedDescription)
        }
        
        return filName
    }
    
    // FIXME: 현재 외부에서 DispatchQueue를 통해 비동기 처리중. 목표는 async한 함수로 만드는 것.
    // FIXME: 이외로 FileIO 관련해서 macOS부터 레거시가 엄청나다보니 어줍잖게 건드리려다 일단 패스함. 차후 천천히 알아보고 개선하기
    func getImage(named: String) -> UIImage? {
        do {
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return UIImage(contentsOfFile: URL(fileURLWithPath: url.absoluteString).appendingPathComponent(named).path)
        } catch {
            return nil
        }
    }
}
