//
//  SetupViewController.swift
//  Tempi
//
//  Created by Yeri Hwang on 2023/10/23.
//

import UIKit
import MessageUI
import SafariServices

final class SettingViewController: BaseViewController {
    
    private let mainView = SettingView()
    
    private let section0Title = ["sectionTitle01".localized, "sectionTitle02".localized, "sectionTitle03".localized]
    private let section1Title = ["sectionTitle04".localized, "sectionTitle05".localized, "sectionTitle06".localized, "sectionTitle07".localized]
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureLayout() {
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        self.navigationItem.title = "navigationTitle".localized
    }
    
    // 메일 사용 가능한지 체크하는 메서드
    private func checkMailAvailability() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setToRecipients(["dpfl420@icloud.com"])
            mailVC.setSubject("Tempi " + "sectionTitle04".localized)
            mailVC.setMessageBody("messageContent".localized, isHTML: false)
            
            self.present(mailVC, animated: true, completion: nil)
        }
        else {
            print("Mail services are not available")
            self.showAlert(title: "messageAlertTitle".localized, message: "mailAlertSubTitle".localized)
        }
    }
    
    // Safari WebView
    private func openWebView(withURL urlString: String) {
        if let url = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
        } else {
            print("Safari services are not available")
            self.showAlert(title: "messageAlertTitle".localized, message: "safariAlertSubTitle".localized)
        }
    }
    
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return section0Title.count
        default:
            return section1Title.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SettingHeaderView()
        
        switch section {
        case 0:
            headerView.titleLabel.text = "headerViewTitle01".localized
        default:
            headerView.titleLabel.text = "headerViewTitle02".localized
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.titleLabel.text = section0Title[indexPath.row]
            cell.versionLabel.isHidden = true
            return cell
        default:
            cell.titleLabel.text = section1Title[indexPath.row]
            switch indexPath.row {
            case 3:
                // 버전 라벨 업데이트
                if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                    cell.versionLabel.text = "\(version)"
                } else {
                    cell.versionLabel.text = ""
                }
                
                cell.chevronImageView.isHidden = true
                cell.versionLabel.isHidden = false
                cell.isUserInteractionEnabled = false
            default:
                cell.chevronImageView.isHidden = false
                cell.versionLabel.isHidden = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        switch section {
        case 0:
            switch row {
            case 0:
                // 알람 설정
                print("프로필 수정하기 탭")
            case 1:
                // 데이터 초기화
                print("데이터 초기화 탭")
            default:
                // 데이터 백업/복구
                print("데이터 백업/복구 탭")
            }
        default:
            switch row {
            case 0:
                // 1:1 문의하기
                print("1:1 문의하기 탭")
                checkMailAvailability()
            case 1:
                // 앱 평가하기
                print("앱 평가하기 탭")
                openWebView(withURL: "https://apps.apple.com/kr/app/tempi-%EA%B8%B0%EC%A4%80%EC%9D%84-%EC%84%B8%EC%9A%B0%EB%8B%A4/id6469019571")
            case 2:
                // 개인정보처리방침
                print("개인정보처리방침 탭")
                openWebView(withURL: "privacyPolicyLink".localized)
            default:
                // 버전정보
                print("버전정보 클릭 불가")
            }
        }
    }
    
}

extension SettingViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
    
}
