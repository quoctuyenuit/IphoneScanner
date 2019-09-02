//
//Localizations
//IMEIScanner
//
//enum is generated from scrip, do not change any in this file.
//created by tuyennq

import Foundation

enum Localizations {
	case NOTI_COPY_SUCCESS_MSG
	case NOTI_SCAN_FAILT
	case TITLE_MANUALLY_SCAN
	case TITLE_AUTOMATIC_SCAN
	case TITLE_CONTACT
	case TITLE_GUIDE
	case TITLE_SETTINGS
	case TITLE_UNLOCK_IPHONE
	case TITLE_CHECK_IMEI
	case TITLE_ACTION_SCAN
	case HOME_MANUALLY_SCAN
	case HOME_AUTOMATIC_SCAN
	case HOME_CONTACT
	case HOME_GUIDE
	case HOME_SETTINGS
	case HOME_UNLOCK_IPHONE
	case HOME_CHECK_IMEI
	case CONTACT_TAODEN
	case CONTACT_PHONE_NUMBER
	case CONTACT_FOOTER
	case BUTTON_COPY_ALL
	case BUTTON_CHECK_IMEI
	case BUTTON_SCAN_IMEI
	case GUIDE_TITLE
	case GUIDE_SUBTITLE1
	case GUIDE_SUBTITLE2
	case GUIDE_SUBTITLE3
	case GUIDE_SUBTITLE4
	case GUIDE_CONTENT1_1
	case GUIDE_CONTENT1_2
	case GUIDE_CONTENT1_3
	case GUIDE_CONTENT2_1
	case GUIDE_CONTENT3_1
	case GUIDE_CONTENT4_1

	var vieMsg: String {
		switch self {
		case .NOTI_COPY_SUCCESS_MSG:
			return "Đã sao chép"
		case .NOTI_SCAN_FAILT:
			return "Không tìm thấy kết quả!"
		case .TITLE_MANUALLY_SCAN:
			return "Quét thủ công"
		case .TITLE_AUTOMATIC_SCAN:
			return "Quét tự động"
		case .TITLE_CONTACT:
			return "Liên hệ"
		case .TITLE_GUIDE:
			return "Hướng dẫn"
		case .TITLE_SETTINGS:
			return "Cài đặt"
		case .TITLE_UNLOCK_IPHONE:
			return "Mở khoá iPhone"
		case .TITLE_CHECK_IMEI:
			return "Kiểm tra IMEI"
		case .TITLE_ACTION_SCAN:
			return "Chạm để quét IMEI"
		case .HOME_MANUALLY_SCAN:
			return "Quét thủ công"
		case .HOME_AUTOMATIC_SCAN:
			return "Quét tự động"
		case .HOME_CONTACT:
			return "Liên hệ"
		case .HOME_GUIDE:
			return "Hướng dẫn"
		case .HOME_SETTINGS:
			return "Cài đặt"
		case .HOME_UNLOCK_IPHONE:
			return "Mở khoá iPhone"
		case .HOME_CHECK_IMEI:
			return "Kiểm tra IMEI"
		case .CONTACT_TAODEN:
			return "Kiểm tra IMEI: taoden.vn"
		case .CONTACT_PHONE_NUMBER:
			return "SĐT:"
		case .CONTACT_FOOTER:
			return "Hệ thống dịch vụ sữa chữa Apple"
		case .BUTTON_COPY_ALL:
			return "Sao chép tất cả"
		case .BUTTON_CHECK_IMEI:
			return "Kiểm tra IMEI"
		case .BUTTON_SCAN_IMEI:
			return "Quét IMEI"
		case .GUIDE_TITLE:
			return "HƯỚNG DẪN SỬ DỤNG"
		case .GUIDE_SUBTITLE1:
			return "I. Quét thủ công"
		case .GUIDE_SUBTITLE2:
			return "II. Quét tự động"
		case .GUIDE_SUBTITLE3:
			return "III. Kiểm tra IMEI"
		case .GUIDE_SUBTITLE4:
			return "IV. Cài đặt tự động sao chép"
		case .GUIDE_CONTENT1_1:
			return "Chọn Quét IMEI để chọn ảnh chứa IMEI cần quét."
		case .GUIDE_CONTENT1_2:
			return "(Ảnh được chọn từ thư viện hoặc camera)"
		case .GUIDE_CONTENT1_3:
			return "Sau khi đã chọn hình ứng dụng tự động quét và hiển thị IMEI quét được"
		case .GUIDE_CONTENT2_1:
			return "Chỉnh cho máy quay thẳng đứng dễ nhìn IMEI rồi sau đó chạm vào màn hình để quét IMEI."
		case .GUIDE_CONTENT3_1:
			return "Sau khi quét được IMEI bạn có thể chọn Kiểm tra IMEI trên bảng kết quả để kiểm tra IMEI trên taoden.vn."
		case .GUIDE_CONTENT4_1:
			return "Bật chế độ tự động sao chép bằng cách bất công tắc ở màn hình cài đặt."
		}
	}

	var enMsg: String {
		switch self {
		case .NOTI_COPY_SUCCESS_MSG:
			return "Already copied"
		case .NOTI_SCAN_FAILT:
			return "No results were found!"
		case .TITLE_MANUALLY_SCAN:
			return "Manual scanning"
		case .TITLE_AUTOMATIC_SCAN:
			return "Auto scanning"
		case .TITLE_CONTACT:
			return "Contact"
		case .TITLE_GUIDE:
			return "Guide"
		case .TITLE_SETTINGS:
			return "Setting"
		case .TITLE_UNLOCK_IPHONE:
			return "Unlock iPhone"
		case .TITLE_CHECK_IMEI:
			return "Check IMEI"
		case .TITLE_ACTION_SCAN:
			return "Touch to scan IMEI"
		case .HOME_MANUALLY_SCAN:
			return "Manual scanning"
		case .HOME_AUTOMATIC_SCAN:
			return "Auto scanning"
		case .HOME_CONTACT:
			return "Contact"
		case .HOME_GUIDE:
			return "Guide"
		case .HOME_SETTINGS:
			return "Setting"
		case .HOME_UNLOCK_IPHONE:
			return "Unlock iPhone"
		case .HOME_CHECK_IMEI:
			return "Check IMEI"
		case .CONTACT_TAODEN:
			return "Check IMEI: taoden.vn"
		case .CONTACT_PHONE_NUMBER:
			return "Phone Number:"
		case .CONTACT_FOOTER:
			return "System of Apple repair services"
		case .BUTTON_COPY_ALL:
			return "Copy all"
		case .BUTTON_CHECK_IMEI:
			return "Check IMEI"
		case .BUTTON_SCAN_IMEI:
			return "Scan IMEI"
		case .GUIDE_TITLE:
			return "GUIDE"
		case .GUIDE_SUBTITLE1:
			return "I. Manual scanning"
		case .GUIDE_SUBTITLE2:
			return "II. Auto scanning"
		case .GUIDE_SUBTITLE3:
			return "III. Check IMEI"
		case .GUIDE_SUBTITLE4:
			return "IV. Auto copy settings"
		case .GUIDE_CONTENT1_1:
			return "Select Scan IMEI to choose to images containing the IMEI to be scanned."
		case .GUIDE_CONTENT1_2:
			return "(Photos selected from gallery or camera)"
		case .GUIDE_CONTENT1_3:
			return "After selecting the image the application automatically scans and displays the scanned IMEI"
		case .GUIDE_CONTENT2_1:
			return "Adjust IMEI vertical camera then touch the screen to scan IMEI."
		case .GUIDE_CONTENT3_1:
			return "After scanning IMEI you can select Check IMEI on the results table to check IMEI on taoden.vn."
		case .GUIDE_CONTENT4_1:
			return "Turn on the automatic copy mode by turning off the switch in the setting screen."
		}
	}
}