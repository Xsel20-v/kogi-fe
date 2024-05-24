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
        let url = URL(string: "wss://kogi-api.onrender.com/")!
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
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
}

extension WebSocketManager: URLSessionWebSocketDelegate {
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("WebSocket did open")
        // Connection succeeded, you can perform additional tasks here if needed
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("WebSocket connection failed with error: \(error)")
            // Connection failed, handle error here
        }
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("WebSocket did close with code: \(closeCode), reason: \(String(describing: reason))")
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didReceiveMessage message: URLSessionWebSocketTask.Message) {
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

