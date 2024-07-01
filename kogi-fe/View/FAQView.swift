//
//  FAQView.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 11/06/24.
//

import SwiftUI

struct FAQView: View {
    @AppStorage("isPatient") var isPatient = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HeaderViewWithTitle(title: "Pusat Bantuan")
                .padding(.bottom, -5)
            
            List {
                if !isPatient {
                    Section(header: Text("FAQ").font(.title).bold()) {
                        FAQDisclosureGroup(question: "Apa itu aplikasi KOGI?", answer: "KOGI adalah aplikasi mobile yang dirancang untuk menghubungkan pasien dengan Dokter Koas yang menawarkan perawatan gigi yang terjangkau. Aplikasi ini membantu pasien menemukan dan mendapatkan perawatan gigi yang dibutuhkan.")
                        
                        FAQDisclosureGroup(question: "Bagaimana cara mendapatkan perawatan gigi lewat aplikasi KOGI?", answer: """
                            Untuk mendapatkan perawatan gigi, ikuti langkah-langkah berikut:
                            1. Unduh dan Daftar: Unduh aplikasi KOGI dan daftar sebagai pasien dengan mengisi informasi yang diminta.
                            2. Pilih Kategori Keluhan: Pilih kategori keluhan gigi Anda.
                            3. Isi Formulir Pertanyaan Keluhan: Isi formulir anamnesis untuk memberikan informasi detail tentang kondisi Anda.
                            4. Review Jawaban: Tinjau jawaban yang telah Anda isi.
                            5. Submit Jawaban: Kirimkan jawaban Anda.
                            6. Tunggu Dihubungi oleh Dokter: Dokter Koas akan menghubungi Anda jika mereka menyetujui untuk menangani keluhan Anda.
                            """)
                        
                        FAQDisclosureGroup(question: "Bagaimana cara memulai percakapan dengan Dokter Koas?", answer: "Hanya Dokter Koas yang bisa memulai percakapan dengan Anda. Setelah Anda mengajukan permintaan perawatan dan Dokter Koas menyetujuinya, mereka akan menghubungi Anda melalui fitur chat di aplikasi.")
                        
                        FAQDisclosureGroup(question: "Apakah dipungut biaya?", answer: "Biaya perawatan tergantung pada persetujuan dengan Dokter Koas. Pastikan untuk mendiskusikan biaya dan persyaratan lain dengan Dokter Koas sebelum memulai perawatan.")
                        
                        FAQDisclosureGroup(question: "Apakah janji temu bisa dibatalkan?", answer: "Tidak, janji temu tidak dapat dibatalkan. Namun, Anda dapat mengatur ulang jadwal janji temu dengan menghubungi Dokter Koas melalui fitur chat di aplikasi.")
                        
                        FAQDisclosureGroup(question: "Berapa banyak perawatan yang dapat dilakukan?", answer: "Setiap pasien hanya dapat memiliki satu perawatan yang sedang berlangsung (ongoing) pada satu waktu. Setelah perawatan selesai, Anda dapat mengajukan perawatan baru.")
                    }
                } else {
                    
                    Section(header: Text("FAQ").font(.title).bold()) {
                        FAQDisclosureGroup(question: "Apa itu aplikasi KOGI?", answer: "KOGI adalah aplikasi mobile yang dirancang untuk menghubungkan Dokter Koas dengan pasien yang membutuhkan perawatan gigi yang terjangkau. Aplikasi ini membantu Dokter Koas menemukan pasien yang memenuhi persyaratan klinis mereka, sehingga mereka dapat menyelesaikan program KOAS dengan lebih efisien.")
                        
                        FAQDisclosureGroup(question: "Bagaimana caranya mendapatkan pasien?", answer: """
                            Untuk mendapatkan pasien melalui aplikasi KOGI, ikuti langkah-langkah berikut:
                            1. Daftar: Unduh aplikasi KOGI dan daftar sebagai Dokter Koas dengan mengisi informasi yang diminta dan mengunggah ijazah Anda untuk verifikasi.
                            2. Pilih Kategori: Pilih kategori departemen yang ingin Anda tangani, seperti Konservasi Gigi, Periodonsia, Bedah Mulut, Pedodonsia, Penyakit Mulut, Prostodonsia, atau Orthodonsia.
                            3. Tinjau Permintaan: Anda akan menerima permintaan perawatan dari pasien. Tinjau informasi keluhan pasien dan anamnesis yang telah mereka isi.
                            4. Mulai Percakapan: Jika Anda setuju untuk menangani keluhan pasien, mulai percakapan dengan mereka melalui fitur chat di aplikasi.
                            5. Jadwalkan Janji Temu: Atur jadwal janji temu dengan pasien melalui fitur penjadwalan di aplikasi.
                            6. Berikan Perawatan: Berikan perawatan gigi sesuai dengan kebutuhan pasien dan isi laporan sesi setelah setiap janji temu.
                            """)
                        
                        FAQDisclosureGroup(question: "Apakah janji temu bisa dibatalkan?", answer: "Janji temu yang telah dijadwalkan dapat dibatalkan jika diperlukan. Jika Anda perlu membatalkan janji temu, segera komunikasikan dengan pasien melalui fitur chat di aplikasi dan atur ulang jadwal janji temu yang baru.")
                        
                        FAQDisclosureGroup(question: "Berapa banyak perawatan yang dapat dilakukan?", answer: "Dokter Koas dapat menangani beberapa perawatan sekaligus. Namun, disarankan untuk bijaksana dalam mengelola jumlah perawatan yang ditangani untuk memastikan setiap pasien menerima perhatian dan perawatan yang optimal. Pastikan untuk mengatur jadwal Anda dengan baik agar tidak terjadi benturan atau penundaan dalam penanganan pasien.")
                    }
                }
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Hubungi Costumer Support")
                    .font(.headline)
                
                HStack {
                    Image(systemName: "envelope")
                    Text("cs.kogi@gmail.com")
                }
            }
            .padding()
            .padding(.bottom)
        }
        .ignoresSafeArea(.all)
    }
}

struct FAQDisclosureGroup: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            Text(answer)
                .padding(.bottom)
        } label: {
            Text(question)
                .font(.headline)
        }
        .padding(.vertical)
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView()
    }
}

