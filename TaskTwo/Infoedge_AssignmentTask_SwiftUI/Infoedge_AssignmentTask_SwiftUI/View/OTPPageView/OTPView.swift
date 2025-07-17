//
//  OTPView.swift
//  Infoedge_AssignmentTask_SwiftUI
//
//  Created by Abhay Chaurasia on 16/07/25.
//

import SwiftUI
 
import SwiftUI

struct OTPView: View {
    let phoneNumber: String

    @State private var otp: String = ""
    @State private var countdown: Int = 59
    @State private var timer: Timer? = nil

    @State private var isLoading = false
    @State private var navigateToNotes = false
    @State private var authToken = ""

    @State private var showValidationError = false
    @State private var validationMessage = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 24) {
            //Spacer()

            // Top phone number + back icon
            HStack(spacing: 8) {
                Text(phoneNumber)
                    .font(.subheadline)
                    .bold()

                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "pencil")
                        .foregroundColor(.blue)
                }
            }

            // Title
            Text("Enter The\nOTP")
                .font(.largeTitle)
                .bold()
                .underline()
                .multilineTextAlignment(.center)

            // OTP Input
            TextField("9999", text: $otp)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .padding()
                .frame(height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .frame(maxWidth: 100)
                .onChange(of: otp) { newValue in
                    if newValue.count > 4 {
                        otp = String(newValue.prefix(4))
                    }
                    showValidationError = false
                }

            // Validation message
            if showValidationError {
                Text(validationMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            // Continue button + timer
            HStack(spacing: 16) {
                Button(action: validateAndSubmitOTP) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(10)
                    }
                }
                .disabled(isLoading)
                .padding()

                Text("00:\(String(format: "%02d", countdown))")
                    .bold()
            }

            Spacer()
        }
        .padding()
        .onAppear(perform: startTimer)
        .onDisappear {
            timer?.invalidate()
        }
        .navigationDestination(isPresented: $navigateToNotes) {
            NotesView(token: authToken)
        }
    }

    // MARK: - Validation
    private func validateAndSubmitOTP() {
        guard !otp.isEmpty else {
            showError("OTP cannot be empty")
            return
        }

        guard otp.count == 4, otp.allSatisfy(\.isNumber) else {
            showError("OTP must be 4 digits")
            return
        }

        verifyOTP()
    }

    // MARK: - Call your API
    private func verifyOTP() {
        isLoading = true
        APIService.verifyOTP(phoneNumber, otp: otp) { token in
            DispatchQueue.main.async {
                isLoading = false
                if let token = token, !token.isEmpty {
                    authToken = token
                    navigateToNotes = true
                } else {
                    showError("Enter valid number")
                }
            }
        }
    }

    private func showError(_ message: String) {
        validationMessage = message
        showValidationError = true
    }

    // MARK: - Timer Logic
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
}
