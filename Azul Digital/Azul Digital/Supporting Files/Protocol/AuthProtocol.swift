//
//  AuthProtocol.swift
//  Azul Digital
//
//  Created by Leonardo Tsuda on 7/25/16.
//  Copyright © 2016 Leonardo Tsuda. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol creatable {
    func create(email: String?, password: String?, completion: (String, String, String) -> ())
}

extension creatable {
    func create(email: String?, password: String?, completion: (String, String, String) -> ()) {
        guard let email = email , !(email.isEmpty), let password = password, !(password.isEmpty) else {
            return completion("Campos vazios", "Favor preencher os campos Email e Senha", "Tentar novamente")
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                if let code = FIRAuthErrorCode(rawValue: (error?.code)!) {
                    switch code {
                    case .errorCodeInvalidEmail:
                        completion("Email inválido: \(code.rawValue)", "Favor preencher no formato usuario@provedor.com.br", "Tentar novamente")
                    case .errorCodeEmailAlreadyInUse:
                        completion("Email em uso: \(code.rawValue)", "Este email já está em uso, favor utilizar outro email", "Tentar novamente")
                    case .errorCodeWeakPassword:
                        completion("Senha insegura: \(code.rawValue)", "Favor utilizar uma senha com mais de 6 dígitos", "Tentar novamente")
                    default:
                        completion("Código: \(code.rawValue)", "\(error?.localizedDescription)", "OK")
                    }
                }
            } else {
                completion("", "", "")
            }
        })
    }
}

protocol loggable {
    func login(email: String?, password: String?, completion: (String, String, String) -> ())
}

extension loggable {
    func login(email: String?, password: String?, completion: (String, String, String) -> ()) {
        guard let email = email , !(email.isEmpty), let password = password, !(password.isEmpty) else {
            return completion("Campos vazios", "Favor preencher os campos Email e Senha", "Tentar novamente")
        }
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                if let code = FIRAuthErrorCode(rawValue: (error?.code)!) {
                    switch code {
                    case .errorCodeInvalidEmail:
                        completion("Email inválido: \(code.rawValue)", "Favor preencher no formato usuario@provedor.com.br", "Tentar novamente")
                    case .errorCodeOperationNotAllowed:
                        completion("Serviço desabilitado: \(code.rawValue)", "Favor entrar em contato com o desenvolvedor", "Tentar novamente")
                    case .errorCodeUserDisabled:
                        completion("Conta desabilitada: \(code.rawValue)", "Favor entrar em contato com o desenvolvedor", "Tentar novamente")
                    case .errorCodeWrongPassword:
                        completion("Senha incorreta: \(code.rawValue)", "Favor verifique sua senha", "Tentar novamente")
                    default:
                        completion("Código: \(code.rawValue)", "\(error?.localizedDescription)", "OK")
                    }
                }
            } else {
                completion("", "", "")
            }
        })
    }
}