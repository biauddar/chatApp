//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Teacher on 2016/05/21.
//  Copyright © 2016年 AKYLab. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    // チャットメッセージ表示テーブル
    @IBOutlet weak var tableView: UITableView!
    
    // テキスト入力
    @IBOutlet weak var textField: UITextField!
    
    // 送信ボタンタップ時イベント
    @IBAction func didTapSendButton(sender: UIButton) {
        // A ?? B => Aの値が存在すればその値をそのまま、存在しない(=nil)場合は、Bの値を使う
        // イメージ: A.exist ? A : B
        let message = textField.text ?? ""
        messageList.append(message)
        
        // テーブルをリロードする
        tableView.reloadData()
        
        // テーブルの表示位置を更新
        
        // テーブルに表示されている行数を取得
        let rowCount = tableView.numberOfRowsInSection(0) // セクションは1個固定なので0指定で良い
        // 表示される行数 = メッセージの数なので以下でもOK
        // let rowCount = messageList.count
        
        // 一番下のセル位置
        let indexPath = NSIndexPath(forRow: rowCount - 1, inSection: 0)
        tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
        
        // メッセージ入力欄をクリアする
        textField.text = ""
    }
    
    // チャットに表示されるメッセージリスト
    var messageList = [String]()
    // 下の書き方でもOK
    // var messageList: [String] = []
}

// DataSourceの中身を定義するために、UITableViewDataSourceに適合させる
extension ChatViewController: UITableViewDataSource {
    
    // テーブルのセクション毎の行数を定義
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    // セル毎のオブジェクトを返す
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "chatCell")
        
        // 何番目のセルかはindexPathから取得できる
        let num = indexPath.row
        cell.textLabel?.text = messageList[num]
        
        return cell
    }
}