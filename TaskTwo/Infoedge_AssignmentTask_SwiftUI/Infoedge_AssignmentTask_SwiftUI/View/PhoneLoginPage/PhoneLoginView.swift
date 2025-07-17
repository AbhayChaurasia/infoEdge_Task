//
//  PhoneLoginView.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 16/07/25.
//

 
import SwiftUI

struct PhoneLoginView: View {
    @State private var phoneNumber: String = ""
    @State private var showError = false
    @State private var isNavigatingToOTP = false

    var body: some View {
        VStack(spacing: 24) {
            //Spacer()

            Text("Get OTP")
                .font(.title2)
                .bold()

            Text("Enter Your\nPhone Number")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            HStack {
                Text("+91")
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                TextField("9999999999", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .onChange(of: phoneNumber) { _ in
                        showError = false
                    }
            }
            .frame(height: 50)

            if showError {
                Text("Please enter a valid 10-digit phone number")
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button(action: {
                if validatePhone() {
                    sendOTP()
                } else {
                    showError = true
                }
            }) {
                Text("Continue")
                    .foregroundColor(.black)
                    .bold()
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Color.yellow)
                    .cornerRadius(30)
            }

            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $isNavigatingToOTP) {
            OTPView(phoneNumber: "+91\(phoneNumber)")
        }
    }

    private func validatePhone() -> Bool {
        return phoneNumber.count == 10 && phoneNumber.allSatisfy { $0.isNumber }
    }

    private func sendOTP() {
        // ✅ Your existing send OTP API logic here
        isNavigatingToOTP = true
    }
}
