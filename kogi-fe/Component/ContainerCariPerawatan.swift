//
//  ContainerCariPerawatan.swift
//  kogi-fe
//
//  Created by Azella Mutyara on 24/05/24.
//

import SwiftUI

struct ContainerCariPerawatan: View {
    
    var treatment: FetchedTreatmentData
    @ObservedObject var treatmentViewModel: TreatmentViewModel
    @Binding var path: NavigationPath
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            Rectangle()
                .frame(width: 360, height: 180)
                .foregroundColor(.white)
                .cornerRadius(20)
                .shadow(radius: 4, y: 4)
                .overlay(
                    GeometryReader { geometry in
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 45))
                            path.addLine(to: CGPoint(x: geometry.size.width, y: 45))
                        }
                        .stroke(Color.gray, lineWidth: 1)
                    }
                )
            
            VStack(alignment: .leading, spacing: -10) {
                HStack {
                    Text(treatment.areaOfSymptom?.joined(separator: ", ") ?? "")
                        .fontWeight(.semibold)
                    Spacer()
                    Button(action: {
                        treatmentViewModel.selectedTreatment = treatment
                        path.append("Detail Perawatan Pending View")
                    }, label: {
                        Image(systemName: "chevron.right")
                    })
                    
                }
                .padding()
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(treatment.images, id: \.self) { imageData in
                            if let uiImage = UIImage(data: Data(base64Encoded: imageData)!) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .padding()
                .offset(y: 5)
                HStack {
                    Image(systemName: "clock.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color("primaryColor"))
                    
                    Text("\(treatment.requestedDate.dateToString()) (\(treatment.requestedDate.timeToString()))")
                        .font(.system(size: 12))
                }
                .padding()
            }
        }
        .frame(width: 360, height: 180)
    }
}

#Preview {
    ContainerCariPerawatan(treatment: .init(patientID: "P1", problemCategory: "Sakit Gigi", symptomsDesc: "Walawe sakit betul a", totalDaysOfSymptom: 3, dateCreated: "2024-06-20T09:41:00", requestedDate: "2024-06-29T09:41:00", treatmentStatus: "ongoing", images: [
        "iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABiSURBVGhD7c+xEYAwEMCwDyuQO/aflDRMIazGtde9n3d+4PrKa1TTqKZRTaOaRjWNahrVNKppVNOoplFNo5pGNY1qGtU0qmlU06imUU2jmkY1jWoa1TSqaVTTqKZRTaOWmQOItwGxNvzd9QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC",
        "iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAABiSURBVGhD7c+xEYAwEMCwDyuQO/aflDRMIazGtde9n3d+4PrKa1TTqKZRTaOaRjWNahrVNKppVNOoplFNo5pGNY1qGtU0qmlU06imUU2jmkY1jWoa1TSqaVTTqKZRTaOWmQOItwGxNvzd9QAAAA5lWElmTU0AKgAAAAgAAAAAAAAA0lOTAAAAAElFTkSuQmCC"
    ]), treatmentViewModel: TreatmentViewModel(), path: .constant(NavigationPath()))
}
