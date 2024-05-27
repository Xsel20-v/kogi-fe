//
//  Constant.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 08/05/24.
//

import SwiftUI

struct Constant {
    struct Colors{
        static let primaryColor = Color("primaryColor")
        static let secondaryColor = Color("secondaryColor")
        static let baseColor = Color("customWhite")
        static let systemGray = Color("systemGray")
        static let systemYellow = Color("systemYellow")
        static let myMessage = Color("myMessage")
        static let notMyMessage = Color("notMyMessage")
    }
    
    struct Images{
        static let cabutGigi = "Cabut Gigi"
        static let gigiTiruan = "Gigi Tiruan"
        static let gusiBengkak = "Gusi Bengkak"
        static let kawatLepasan = "Kawat Lepasan"
        static let sakitGigi = "Sakit Gigi"
        static let sariawan = "Sariawan"
        static let karangGigi = "Karang Gigi"
        static let homeBackground = "Home Background"
    }
    
    struct Categories{
        static let cabutGigi = "Cabut Gigi"
        static let gigiTiruan = "Gigi Tiruan"
        static let gusiBengkak = "Gusi Bengkak"
        static let kawatLepasan = "Kawat Lepasan"
        static let sakitGigi = "Sakit Gigi"
        static let sariawan = "Sariawan"
        static let karangGigi = "Karang Gigi"
    }
    
    struct Description{
        static let sakitGigi = "Ditandai dengan adanya rasa sakit pada gigi/tidak nyaman saat digunakan/gigi berlubang.\n\nPenyebab :\n1. Sering makan makanan yang manis/lengket\n2. Kurang bersih ketika menyikat gigi"
        static let karangGigi = "Gigi terasa kotor/terdapat warna kekuningan atau kecoklatan pada gigi.\n\nPenyebab :\n1. Kurang bersih ketika menyikat gigi"
        static let cabutGigi = "Terdapat masalah pada gigi sehingga perlu dicabut.\n\nPenyebab : \n1. Lubang pada gigi yang tidak segera diobati/ditambal\n2. Untuk kebutuhan merapikan gigi/perawatan ortodontik/kawat"
        static let gusiBengkak = "Terdapat pembengkakan pada gusi/gusi mudah berdarah.\n\nPenyebab :\n1. Kurang bersih ketika menyikat gigi\n2. Teknik menyikat gigi yang kurang benar"
        static let sariawan = "Terdapat sariawan/luka/bercak pada rongga mulut.\n\nPenyebab :\n1. Pola hidup yang kurang baik\n2. Kurangnya makan buah-buahan atau sayur-sayuran"
        static let gigiTiruan = "Terdapat keluhan kehilangan gigi.\n\nPenyabab :\n1. Faktor usia\n2. Bekas pencabutan gigi"
        static let kawatLepasan = "Terdapat keluhan susunan gigi yang tidak rapi.\n\nPenyebab :\n1. Gigi tumbuh di posisi yang kurang tepat\n2. Ukuran rahang yang lebih kecil dari lengkung gigi"
    }
    
    struct Status {
        static let pending = "pending"
        static let ongoing = "ongoing"
        static let done = "done"
    }
    
    struct UIConstants {
        // Define constants for layout measurements
        static let containerWidthRatio: CGFloat = 0.9
        static let containerHeightRatio: CGFloat = 0.235
        static let height2Ratio: CGFloat = 0.052
        static let cornerRadius: CGFloat = 20
        static let circleWidth: CGFloat = 73
        
        // Define constants for font sizes (as ratios of screen width)
        static let fontSize16Ratio: CGFloat = 0.04
        static let fontSize12Ratio: CGFloat = 0.03
    }
    
    struct OnboardingItems {
        static let onboardingItems = [
            OnboardingData(image: "OnBoarding1", title: "Temukan Berbagai Perawatan Gigi", description: "Temukan berbagai jenis perawatan dengan harga yang lebih terjangkau"),
            OnboardingData(image: "OnBoarding2", title: "Perawatan oleh Koas Terverifikasi", description: "Perawatan ditangani oleh mahasiswa lulusan kedokteran (S.K.G) yang telah diverifikasi"),
            OnboardingData(image: "OnBoarding3", title: "Masuk sebagai pasien atau dokter?", description: "")
        ]
    }
}

extension UserDefaults {
    private enum Keys {
        static let userID = "userID"
    }
    
    var userString: String? {
        get {
            return string(forKey: Keys.userID)
        }
        set {
            set(newValue, forKey: Keys.userID)
        }
    }
}

extension Date {
    func currentDateString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
