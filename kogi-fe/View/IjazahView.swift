import SwiftUI

struct IjazahView: View {
    @Binding var path: NavigationPath
    @Binding var tabSelection: Int
    
    @State private var selectedImage: String?
    @State private var isEligible_: Bool = false
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    @AppStorage("certificate") var certificate = "iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABiSURBVGhD7c+xEYAwEMCwDyuQO/aflDRMIazGtde9n3d+4PrKa1TTqKZRTaOaRjWNahrVNKppVNOoplFNo5pGNY1qGtU0qmlU06imUU2jmkY1jWoa1TSqaVTTqKZRTaOWmQOItwGxNvzd9QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC"
    @AppStorage("isEligible") var isEligible: Bool = false
    @AppStorage("userID") var userID = ""
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(Constant.Colors.baseColor)
                    .ignoresSafeArea()
                VStack {
                    HeaderViewWithTitle(title: "Ijazah")
                    
                    if let image = base64ToUIImage(base64String: certificate) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 6/7 * geometry.size.width)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    } else {
                        Text("Ijazah tidak sah")
                            .foregroundColor(.red)
                    }
                    if isEligible_ {
                        HStack {
                            Spacer()
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                                .frame(width: 6/7 * geometry.size.width, height: 75)
                                .foregroundColor(Color.green)
                                .overlay {
                                    ZStack {
                                        Color(.green)
                                            .opacity(0.075)
                                        VStack {
                                            Text("Ijazah anda telah terverifikasi, silahkan mencari pasien")
                                                .font(.system(size: 12))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.green)
                                                .bold()
                                        }
                                    }
                                    
                                }
                            Spacer()
                        }
                            
                    } else {
                        HStack {
                            Spacer()
                            Rectangle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [10, 5]))
                                .frame(width: 6/7 * geometry.size.width, height: 75)
                                .foregroundColor(Color.yellow)
                                .overlay {
                                    ZStack {
                                        Color(.yellow)
                                            .opacity(0.075)
                                        VStack {
                                            Text("Ijazah anda dalam tahap verifikasi, harap menunggu")
                                                .font(.system(size: 12))
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.orange)
                                                .bold()
                                        }
                                    }
                                    
                                }
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
                .ignoresSafeArea()
            }
            .onAppear(perform: {
                Task {
                    isEligible = await loginViewModel.checkEligibility(coassID: userID)
                    isEligible_ = isEligible
                }
            })
        }
    }
    
    func base64ToUIImage(base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else {
            return nil
        }
        return UIImage(data: imageData)
    }
}

#Preview {
    IjazahView(path: .constant(NavigationPath()), tabSelection: .constant(2), loginViewModel: LoginViewModel())
}
