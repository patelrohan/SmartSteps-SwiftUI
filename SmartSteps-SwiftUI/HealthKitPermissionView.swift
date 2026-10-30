//
//  HealthKitPermissionView.swift
//  SmartSteps-SwiftUI
//
//  Created by Rohan Patel on 10/29/26.
//

import SwiftUI
import HealthKitUI

struct HealthKitPermissionView: View {

    @Environment(HealthKitManager.self) private var hkManager
    @Environment(\.dismiss) private var dismiss

    @State private var isShowingHalthKitPermission = false

    @Binding var hasSeenHealthKitPermissionView: Bool

    var description = "This app displays your steps count and workout data in interactive charts. \n\nYou can also add these data to Apple Health app from this app. Your data is private and secure."

    var body: some View {

        VStack(spacing: 30){

            VStack(alignment: .leading){
                Image(.appleHealthIcon)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .shadow(color: .gray.opacity(0.25), radius: 15)
                    .padding(.bottom, 12)

                Text("Apple Health Integration")
                    .font(.title2).bold()

                Text(description)
                    .foregroundStyle(.secondary)
                    .padding(.top, 5)
            }.padding(30)

            Button("Connect Apple Health"){
                isShowingHalthKitPermission = true
            }
            .buttonStyle(.glassProminent)
            .tint(.pink)
        }
        .interactiveDismissDisabled()
        .onAppear(perform: {
            hasSeenHealthKitPermissionView = true
        })
        .healthDataAccessRequest(store: hkManager.store,
                                 shareTypes: hkManager.types,
                                 readTypes: hkManager.types,
                                 trigger: isShowingHalthKitPermission) { result in
            switch result{
            case .success(let success):
                dismiss()
            case .failure(let failure):
                //TODO: handle failure
                dismiss()
            }
        }
    }
}

#Preview {
    HealthKitPermissionView(hasSeenHealthKitPermissionView: .constant(true))
        .environment(HealthKitManager())
}
