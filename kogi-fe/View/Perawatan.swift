import SwiftUI

struct Perawatan: View {
    
    @State private var categoryPerawatan: String = "Sakit Gigi"
    @State private var statusPerawatan: String = "pending"
    @State private var namaKOAS: String = "Azella"
    @State private var departemen: String = "Konservasi Gigi"
    @State private var dataIsRetrieved = false
    @State private var imageIsConverted = false
    @State private var showSheet = false
    @State private var showAlert = false
    @State private var isEligible_ = false
    
    @Binding var path: NavigationPath
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @ObservedObject var loginViewModel: LoginViewModel
    
    @State var images: [UIImage] = []
    
    @AppStorage("isPatient") var isPatient = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email_ = "1@2.com"
    @AppStorage("password") var password_ = "123"
    @AppStorage("profilePicture") var profilePicture: String = ""
    @AppStorage("certificate") var certificate: String = ""
    @AppStorage("isEligible") var isEligible: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .leading) {
                    HomeBackground(path: $path)
                        .padding(.bottom, 15)
                    VStack {
                        HStack {
                            Text("Kategori")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.leading, 30)
                        if isPatient {
                            HStack {
                                Button(action: {
                                    path.append(Constant.Categories.sakitGigi)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                                })
                                Spacer()
                                Button(action: {
                                    path.append(Constant.Categories.karangGigi)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.karangGigi, image: Constant.Images.karangGigi)
                                })
                                Spacer()
                                Button(action: {
                                    path.append(Constant.Categories.cabutGigi)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.cabutGigi, image: Constant.Images.cabutGigi)
                                })
                                Spacer()
                                Button(action: {
                                    path.append(Constant.Categories.gigiTiruan)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.gigiTiruan, image: Constant.Images.gigiTiruan)
                                })
                            }
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                            
                            HStack {
                                Button(action: {
                                    path.append(Constant.Categories.kawatLepasan)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.kawatLepasan, image: Constant.Images.kawatLepasan)
                                })
                                Spacer()
                                Button(action: {
                                    path.append(Constant.Categories.gusiBengkak)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.gusiBengkak, image: Constant.Images.gusiBengkak)
                                })
                                Spacer()
                                Button(action: {
                                    path.append(Constant.Categories.sariawan)
                                }, label: {
                                    CategoryButton(text: Constant.Categories.sariawan, image: Constant.Images.sariawan)
                                })
                                Spacer()
                                CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                                    .disabled(true)
                                    .opacity(0)
                            }
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        } else {
                            HStack {
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.konservasiGigi)
                                    } else {
                                        showAlert = true
                                    }
                                }, label: {
                                    CategoryButton(text: Constant.Categories.konservasiGigi, image: Constant.Images.sakitGigi)
                                })
                                Spacer()
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.periodonsia)
                                    } else {
                                        showAlert = true
                                    }
                                    
                                }, label: {
                                    CategoryButton(text: Constant.Categories.periodonsia, image: Constant.Images.karangGigi)
                                })
                                Spacer()
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.bedahMulut)
                                    } else {
                                        showAlert = true
                                    }
                                }, label: {
                                    CategoryButton(text: Constant.Categories.bedahMulut, image: Constant.Images.cabutGigi)
                                })
                                Spacer()
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.pedodonsia)
                                    } else {
                                        showAlert = true
                                    }
                                }, label: {
                                    CategoryButton(text: Constant.Categories.pedodonsia, image: Constant.Images.pedodonsia)
                                })
                            }
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                            
                            HStack {
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.penyakitMulut)
                                    } else {
                                        showAlert = true
                                    }
                                }, label: {
                                    CategoryButton(text: Constant.Categories.penyakitMulut, image: Constant.Images.sariawan)
                                })
                                Spacer()
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.prostodonsia)
                                    } else {
                                        showAlert = true
                                    }
                                }, label: {
                                    CategoryButton(text: Constant.Categories.prostodonsia, image: Constant.Images.gigiTiruan)
                                })
                                Spacer()
                                Button(action: {
                                    if isEligible_ {
                                        path.append(Constant.Categories.orthodonsia)
                                    } else {
                                        showAlert = true
                                    }
                                }, label: {
                                    CategoryButton(text: Constant.Categories.orthodonsia, image: Constant.Images.kawatLepasan)
                                })
                                Spacer()
                                CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                                    .disabled(true)
                                    .opacity(0)
                            }
                            .padding(.leading, 30)
                            .padding(.trailing, 30)
                        }

                    }
                    .padding(.bottom, 15)
                    
                    VStack {
                        HStack {
                            Text("Perawatan")
                                .fontWeight(.semibold)
                            Button(action: {
                                Task {
                                    dataIsRetrieved = await treatmentViewModel.getOnGoingTreatmentData(userID: userID)
                                }
                            }, label: {
                                Image(systemName: "arrow.clockwise")
                                    .foregroundColor(Constant.Colors.primaryColor)
                            })
                            Spacer()
                            if !isPatient {
                                Button(action:{
                                    path.append("OnGoing Treatment List")
                                }) {
                                    Text("Lihat semua")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 12))
                                }
                                .padding(.trailing, 30)
                            }
                        }
                        .padding(.leading, 30)
                        
                        if dataIsRetrieved {
                            ContainerPerawatan(treatment: treatmentViewModel.fetchedTreatmentData!)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .onTapGesture {
                                    if treatmentViewModel.fetchedTreatmentData?.treatmentStatus == "pending" {
                                        showSheet = true
                                    } else {
                                        path.append("Detail Perawatan")
                                    }
                                    
                                }
                        } else {
                            Text("Tidak ada perawatan")
                                .padding()
                        }
                    }
                    Spacer()
                }
                .ignoresSafeArea()
                .background(Constant.Colors.baseColor)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .onAppear(perform: {
                    Task {
                        if !isPatient {
                            isEligible = await loginViewModel.checkEligibility(coassID: userID)
                            isEligible_ = isEligible
                        }
                        dataIsRetrieved = await treatmentViewModel.getOnGoingTreatmentData(userID: userID)
                        if let images = await treatmentViewModel.getImages() {
                            self.images = images
                            imageIsConverted = true
                        } else {
                            print("GADA MAS FOTONYA!")
                        }
                    }
                })
                .sheet(isPresented: $showSheet, content: {
                    OnGoingTreatmentView(showSheet: $showSheet, treatmentViewModel: treatmentViewModel)
                        .hideTabBar()
                })

            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Anda belum bisa mengakses fitur ini"),
                    message: Text("Tunggu admin melakukan verifikasi atas ijazah anda"),
                    dismissButton: .default(Text("Tutup")) {
                        self.showAlert = false
                    }
                )
            }
        }
    }
}

struct HomeBackground: View {
    var homeBackgroundWidth: CGFloat = 393
    var homeBackgroundHeight: CGFloat = 277.69
    
    @AppStorage("isPatient") var isPatient = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("userID") var userID = "P2"
    @AppStorage("username") var username = "Axel"
    @AppStorage("dob") var dob = "2002-07-20"
    @AppStorage("email") var email_ = "1@2.com"
    @AppStorage("password") var password_ = "123"
    @AppStorage("profilePicture") var profilePicture: String = ""
    @AppStorage("certificate") var certificate: String = ""
    
    @Binding var path: NavigationPath
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(Constant.Images.homeBackground)
                .resizable()
                .frame(width: homeBackgroundWidth, height: homeBackgroundHeight)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Halo, " + username + "!")
                        .bold()
                    Text(isPatient ? "Bagaimana kondisi gigi kamu?" : "Semangat melayani pasien ya!")
                        .opacity(0.6)
                }
                Spacer()
                Button(action: {
                    path.append("Riwayat Perawatan")
                }) {
                    Image(systemName: "clock.fill")
                }
            }
            .foregroundColor(Constant.Colors.baseColor)
            .padding(.top, 70)
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
    }
}

#Preview {
    Perawatan(path: .constant(NavigationPath()), treatmentViewModel: TreatmentViewModel(), loginViewModel: LoginViewModel())
}

