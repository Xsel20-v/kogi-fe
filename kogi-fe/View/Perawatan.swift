import SwiftUI

struct Perawatan: View {
    
    @State var category: String = "Sakit Gigi"
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading){
                HomeBackground()
                    .padding(.bottom, 15)
                CategorySection()
                    .padding(.bottom, 15)
                
                VStack {
                    HStack {
                        Text("Perawatan")
                            .fontWeight(.semibold)
                        Spacer()
                       
                    }
                    .padding(.leading, 30)
                }
                Spacer()
               
            }
            .ignoresSafeArea()
            .background(Constant.Colors.baseColor)
        }
    }
}

struct HomeBackground: View {
    private var name : String = "Dicky"
    private var homeBackgroundWidth: CGFloat = 393
    private var homeBackgroundHeight: CGFloat = 277.69
    var body: some View{
        ZStack (alignment : .topLeading) {
            Image(Constant.Images.homeBackground)
                .resizable()
                .frame(width: homeBackgroundWidth, height: homeBackgroundHeight)
            
            HStack {
                VStack (alignment: .leading) {
                    Text("Halo, " + name + "!")
                        .bold()
                    Text("Bagaimana kondisi gigi kamu?")
                        .opacity(0.6)
                }
                
                Spacer()
                
                Button(action: {}, label: {
                    Image(systemName: "clock.fill")
                })
            }
            .foregroundColor(Constant.Colors.baseColor)
            .padding(.top, 70)
            .padding(.leading, 30)
            .padding(.trailing, 30)
                
                
        }
    }
}

struct CategorySection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Kategori")
                    .fontWeight(.semibold)
                Spacer()
               
            }
            .padding(.leading, 30)
            HStack {
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.sakitGigi)) {
                    CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                }
                Spacer()
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.karangGigi)) {
                    CategoryButton(text: Constant.Categories.karangGigi, image: Constant.Images.karangGigi)
                }
                
                Spacer()
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.cabutGigi)) {
                    CategoryButton(text: Constant.Categories.cabutGigi, image: Constant.Images.cabutGigi)
                }
                
                Spacer()
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.gigiTiruan)) {
                    CategoryButton(text: Constant.Categories.gigiTiruan, image: Constant.Images.gigiTiruan)
                }
          
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            
            HStack {
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.kawatLepasan)) {
                    CategoryButton(text: Constant.Categories.kawatLepasan, image: Constant.Images.kawatLepasan)
                }
                
                Spacer()
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.gusiBengkak)) {
                    CategoryButton(text: Constant.Categories.gusiBengkak, image: Constant.Images.gusiBengkak)
                }
                
                Spacer()
                NavigationLink(destination: DeskripsiKeluhan(category: Constant.Categories.sariawan)) {
                    CategoryButton(text: Constant.Categories.sariawan, image: Constant.Images.sariawan)
                }
                
                Spacer()
                CategoryButton(text: Constant.Categories.sakitGigi, image: Constant.Images.sakitGigi)
                    .disabled(true)
                    .opacity(0)
          
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
        }
    }
}

#Preview {
    Perawatan()
}
