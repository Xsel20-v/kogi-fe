//
//  WebSocketManager.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import Foundation

class WebSocketManager: NSObject, ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?
    @Published var receivedMessage: String = ""
    
    func connect() {
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        guard let url = URL(string: "wss://kogi-ws.onrender.com/azella") else {
            fatalError("Invalid URL")
        }
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        
        receiveMessage()
    }
    
    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    func sendMessage(_ message: String) {
        let message = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(message) { error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
    }
    
    func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self?.receivedMessage = text
                    }
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
                self?.receiveMessage() // Keep receiving messages
            case .failure(let error):
                print("WebSocket receiving error: \(error)")
            }
        }
    }
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket did open")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("WebSocket connection failed with error: \(error)")
        }
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket did close with code: \(closeCode), reason: \(String(describing: reason))")
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didReceiveMessage message: URLSessionWebSocketTask.Message) {
        print("message recieved")
        switch message {
        case .string(let text):
            DispatchQueue.main.async {
                self.receivedMessage = text
            }
        case .data(let data):
            print("Received binary message: \(data)")
        @unknown default:
            fatalError()
        }
    }
}

