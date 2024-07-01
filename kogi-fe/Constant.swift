//
//  Constant.swift
//  kogi-fe
//
//  Created by Jonathan Axel Benaya on 08/05/24.
//

import SwiftUI

struct Constant {
    
    static let sampleTreatment = FetchedTreatmentData(
        treatmentID: "12345",
        patientID: "patient123",
        coassID: "coass123",
        problemCategory: "Sakit Gigi",
        areaOfSymptom: ["Taring atas", "Geraham atas", "Taring bawah", "Geraham bawah"],
        symptomsDesc: "Gigi saya terasa sakit sejak beberapa hari lalu, dan semakin parah ketika saya makan atau minum sesuatu yang dingin atau panas. Rasa nyerinya tajam dan berdenyut, menyebar hingga ke rahang dan kadang-kadang membuat kepala saya pusing.",
        totalDaysOfSymptom: 3,
        dateCreated: "2023-06-20T09:41:00Z",
        requestedDate: "2023-06-29T09:41:00Z",
        treatmentStatus: "pending",
        images: []
    )
    
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
        static let pedodonsia = "Pedodonsia"
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
        static let konservasiGigi = "Konservasi Gigi"
        static let periodonsia = "Periodonsia"
        static let bedahMulut = "Bedah Mulut"
        static let pedodonsia = "Pedodonsia"
        static let penyakitMulut = "Penyakit Mulut"
        static let prostodonsia = "Prostodonti"
        static let orthodonsia = "Orthodonsia"
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
    func currentDateString(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func timeToString(format: String = "HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

extension String {
    func dateToString(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            print(dateFormatter.string(from: date))
            return dateFormatter.string(from: date)
        }
        return "Invalid date"
    }
    
    func timeToString(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = formatter.date(from: self) {
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm"
            return timeFormatter.string(from: date)
        }
        return "Invalid time"
    }
    
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            return dateFormatter.date(from: self)
        }
}
