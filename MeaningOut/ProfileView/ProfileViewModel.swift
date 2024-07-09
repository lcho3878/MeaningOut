//
//  ProfileViewModel.swift
//  MeaningOut
//
//  Created by 이찬호 on 7/9/24.
//

import Foundation

final class ProfileViewModel {
    
    var inputNickname = Observable<String?>(nil)
    var completeButtonClicked: Observable<Void?> = Observable(nil)
    var saveButtonClikced: Observable<Void?> = Observable(nil)
    
    var outputNickname = Observable<String>("")
    var outputError = Observable<Constant.NicknameValid?>(nil)
    
    init() {
        inputNickname.bind { value in
            guard let value else { return }
            self.configureValidCheckLabel(value)
        }
        saveButtonClikced.bind { _ in
            self.updateNickname(self.inputNickname.value)
        }
    }
    
    private func configureValidCheckLabel(_ nickname: String?) {
        guard (nickname != nil) else { return }
        do {
            let result = try checkValid(nickname)
            outputNickname.value = result.validResult
        }
        catch {
            guard let error = error as? Constant.NicknameValid else { return }
            outputNickname.value = error.validResult
        }
    }
    
    @discardableResult
    private func checkValid(_ text: String?) throws -> Constant.NicknameValid {
        typealias NicknameValid = Constant.NicknameValid
        guard let text = text, text.count >= 2, text.count < 10 else { throw NicknameValid.nicknameLength}
        let special: [Character] = ["@", "#", "$", "%"]
        let number: [Character] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        for char in text {
            if special.contains(char) {
                throw NicknameValid.containSpecial
            }
            else if number.contains(char) {
                throw NicknameValid.containNumber
            }
        }
        return .correct
    }
    
    private func isValidNickname(_ nickname: String) -> Bool {
        do {
            try checkValid(nickname)
            outputError.value = nil
            return true
        }
        catch {
            guard let error = error as? Constant.NicknameValid else { return false }
            outputError.value = error
            return false
        }
    }
    
    private func updateNickname(_ nickname: String?) {
        guard let nickname = inputNickname.value else { return }
        guard isValidNickname(nickname) else { return }
        User.nickname = nickname
    }
    
    
}
