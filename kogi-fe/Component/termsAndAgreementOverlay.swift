//
//  termsAndAgreementOverlay.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 10/06/24.
//

import SwiftUI

struct termsAndAgreementOverlay: View {
    @Binding var showOverlay: Bool
    @State var role : String = ""
    @AppStorage("isPatient") var isPatient = false
    
    var body: some View {
        ZStack {
            Color(Color.black.opacity(0.3))
            
            ZStack{
                Rectangle()
                    .foregroundColor(.white)
                    .cornerRadius(20)
                
                VStack {
                    Text("Syarat dan Ketentuan untuk \(role)")
                        .bold()
                        .padding()
                        .padding(.top, 10)
                    
                    ScrollView {
                        termsAndAgreementText()
                    }
                    .padding(.bottom, 10)
                    .padding(.horizontal, 25)
                    
                    Button(action: {
                        showOverlay = false
                    })
                    {
                        ZStack{
                            Rectangle()
                                .frame(width: 300, height: 40)
                                .cornerRadius(20)
                                .foregroundColor(Color("primaryColor"))
                                .shadow(radius: 4, y: 4)
                            
                            Text("Tutup")
                                .foregroundStyle(Color.white)
                                .font(.system(size: 17))
                            
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .frame(width: 350, height: 600)
        }
        .ignoresSafeArea()
        .onAppear {
            if isPatient {
                self.role = "Pasien"
            } else {
                self.role = "KOAS Dokter Gigi"
            }
        }
    }
    
    struct termsAndAgreementText: View {
        
        @AppStorage("isPatient") var isPatient = false
        
        var body: some View {
            VStack(alignment: .leading) {
                if isPatient {
                    Text("1. Pendaftaran Akun dan Verifikasi\n")
                        .bold()
                    Text("1.1. Anda harus mendaftar untuk membuat akun guna menggunakan aplikasi KOGI sebagai pasien.\n")
                        .padding(.leading, 15)
                    Text("1.2. Selama pendaftaran, Anda diharuskan memberikan informasi yang akurat dan lengkap, termasuk nama lengkap, alamat email, dan kata sandi.\n")
                        .padding(.leading, 15)
                    Text("1.3. KOGI berhak memverifikasi informasi yang diberikan dan menolak akses ke aplikasi jika informasi tersebut ditemukan tidak akurat atau tidak lengkap.\n")
                        .padding(.leading, 15)
                    
                    Text("2. Penggunaan Aplikasi\n").bold()
                    Text("2.1. Anda setuju untuk menggunakan aplikasi hanya untuk tujuan mencari dan menerima perawatan gigi dari Dokter Koas.\n")
                        .padding(.leading, 15)
                    Text("2.2. Anda tidak boleh menggunakan aplikasi untuk kegiatan yang melanggar hukum atau penipuan.\n")
                        .padding(.leading, 15)
                    
                    Text("3. Interaksi dengan Dokter Koas\n").bold()
                    Text("3.1. Anda bertanggung jawab untuk menjaga komunikasi yang sopan dan jujur dengan Dokter Koas.\n")
                        .padding(.leading, 15)
                    Text("3.2. Anda harus memberikan informasi yang akurat dan lengkap mengenai kesehatan gigi dan riwayat medis yang relevan.\n")
                        .padding(.leading, 15)
                    Text("3.3. Anda diwajibkan untuk mengikuti instruksi dan saran yang diberikan oleh Dokter Koas selama perawatan.\n")
                        .padding(.leading, 15)
                    
                    Text("4. Penjadwalan dan Janji Temu\n").bold()
                    Text("4.1. Anda bertanggung jawab untuk mengatur jadwal sendiri dan memastikan ketersediaan untuk janji temu sebagaimana yang telah disepakati.\n")
                        .padding(.leading, 15)
                    Text("4.2. Setiap perubahan pada jadwal janji temu harus segera dikomunikasikan kepada Dokter Koas.\n")
                        .padding(.leading, 15)
                    Text("4.3. Anda wajib hadir dalam semua janji temu yang telah disepakati. Jika tidak dapat hadir, Anda harus memberi tahu Dokter Koas sesegera mungkin dan mengatur ulang jadwal janji temu.\n")
                        .padding(.leading, 15)
                    
                    Text("5. Privasi dan Keamanan Data\n").bold()
                    Text("5.1. Data pribadi dan informasi medis Anda akan ditangani dengan tingkat kerahasiaan tertinggi dan mematuhi peraturan yang berlaku.\n")
                        .padding(.leading, 15)
                    Text("5.2. KOGI menerapkan langkah-langkah keamanan untuk melindungi data pribadi Anda, tetapi Anda juga bertanggung jawab untuk menjaga keamanan kredensial login Anda.\n")
                        .padding(.leading, 15)
                    
                    Text("6. Tanggung Jawab\n").bold()
                    Text("6.1. KOGI tidak bertanggung jawab atas kerugian atau perselisihan yang timbul dari interaksi antara pasien dan Dokter Koas.\n")
                        .padding(.leading, 15)
                    Text("6.2. Anda setuju untuk membebaskan dan melindungi KOGI dari klaim, kerugian, atau biaya yang timbul dari penggunaan aplikasi atau layanan yang diterima.\n")
                        .padding(.leading, 15)
                    
                    Text("7. Penghentian\n").bold()
                    Text("7.1. KOGI berhak untuk menghentikan atau menangguhkan akun Anda kapan saja jika Anda ditemukan melanggar syarat dan ketentuan ini.\n")
                        .padding(.leading, 15)
                    Text("7.2. Anda dapat menghentikan akun Anda kapan saja dengan mengikuti prosedur yang diuraikan dalam aplikasi.\n")
                        .padding(.leading, 15)
                    
                    Text("*Dengan menggunakan aplikasi KOGI, Anda mengakui bahwa Anda telah membaca, memahami, dan setuju untuk terikat oleh syarat dan ketentuan ini.*\n")
                        .padding(.top, 10)
                    
                } else {
                    Text("1. Pendaftaran Akun dan Verifikasi\n").bold()
                    Text("1.1. Anda harus mendaftar untuk membuat akun guna menggunakan aplikasi KOGI sebagai KOAS Dokter Gigi.\n")
                        .padding(.leading, 15)
                    Text("1.2. Selama pendaftaran, Anda diharuskan memberikan informasi yang akurat dan lengkap, termasuk nama lengkap, alamat email, kata sandi, dan salinan ijazah yang terverifikasi.\n")
                        .padding(.leading, 15)
                    Text("1.3. KOGI berhak memverifikasi informasi yang diberikan dan menolak akses ke aplikasi jika informasi tersebut ditemukan tidak akurat atau tidak lengkap.\n")
                        .padding(.leading, 15)
                    
                    Text("2. Penggunaan Aplikasi\n").bold()
                    Text("2.1. Anda setuju untuk menggunakan aplikasi hanya untuk tujuan menghubungkan dengan pasien dan memberikan perawatan gigi sesuai dengan persyaratan program KOAS Anda.\n")
                        .padding(.leading, 15)
                    Text("2.2. Anda tidak boleh menggunakan aplikasi untuk kegiatan yang melanggar hukum atau penipuan.\n")
                        .padding(.leading, 15)
                    
                    Text("3. Interaksi dengan Pasien\n").bold()
                    Text("3.1. Anda bertanggung jawab untuk menjaga perilaku profesional dan kerahasiaan dalam semua interaksi dengan pasien.\n")
                        .padding(.leading, 15)
                    Text("3.2. Anda harus memastikan bahwa semua perawatan yang diberikan sesuai dengan standar dan etika medis.\n")
                        .padding(.leading, 15)
                    Text("3.3. Anda diwajibkan untuk memperbarui status perawatan dan menjaga catatan yang akurat dari interaksi pasien dan sesi perawatan.\n")
                        .padding(.leading, 15)
                    
                    Text("4. Penjadwalan dan Janji Temu").bold()
                    Text("4.1. Anda bertanggung jawab untuk mengatur jadwal sendiri dan memastikan ketersediaan untuk janji temu dengan pasien sebagaimana yang telah disepakati.\n")
                        .padding(.leading, 15)
                    Text("4.2. Setiap perubahan pada jadwal janji temu harus segera dikomunikasikan kepada pasien.\n")
                        .padding(.leading, 15)
                    
                    Text("5. Privasi dan Keamanan Data\n").bold()
                    Text("5.1. Anda harus menangani semua data pasien dengan tingkat kerahasiaan tertinggi dan mematuhi undang-undang perlindungan data yang berlaku.\n")
                        .padding(.leading, 15)
                    Text("5.2. KOGI menerapkan langkah-langkah keamanan untuk melindungi data pribadi Anda, tetapi Anda juga bertanggung jawab untuk menjaga keamanan kredensial login Anda.\n")
                        .padding(.leading, 15)
                    
                    Text("6. Tanggung Jawab\n").bold()
                    Text("6.1. KOGI tidak bertanggung jawab atas kerugian atau perselisihan yang timbul dari interaksi antara KOAS Dokter Gigi dan pasien.\n")
                        .padding(.leading, 15)
                    Text("6.2. Anda setuju untuk membebaskan dan melindungi KOGI dari klaim, kerugian, atau biaya yang timbul dari penggunaan aplikasi atau layanan yang diberikan.\n")
                        .padding(.leading, 15)
                    
                    Text("7. Penghentian\n").bold()
                    Text("7.1. KOGI berhak untuk menghentikan atau menangguhkan akun Anda kapan saja jika Anda ditemukan melanggar syarat dan ketentuan ini.\n")
                        .padding(.leading, 15)
                    Text("7.2. Anda dapat menghentikan akun Anda kapan saja dengan mengikuti prosedur yang diuraikan dalam aplikasi.\n")
                        .padding(.leading, 15)
                    
                    Text("*Dengan menggunakan aplikasi KOGI, Anda mengakui bahwa Anda telah membaca, memahami, dan setuju untuk terikat oleh syarat dan ketentuan ini.*\n")
                        .padding(.top, 10)
                }
            }
        }
    }
}

#Preview {
    termsAndAgreementOverlay(showOverlay: .constant(true))
}
