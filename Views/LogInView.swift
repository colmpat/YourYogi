//
//  LogInView.swift
//  YourYogi
//
//  Created by Colm Lang on 6/22/21.
//

import SwiftUI
import Firebase

struct LogInView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var logInVM = LogInViewModel()
    
    init() {
        UITextField.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            //Log in Screen
            ZStack(alignment: .topLeading){
                Color("lightNeutral")
                    .ignoresSafeArea()
                LazyVStack(alignment: .center, spacing: 0){
                    LottieView(name: "loginAnimation")
                        .frame(height: UIScreen.main.bounds.height / 3)
                    
                    Text("Log In to YourYogi")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color("primary"))
                        .padding(.bottom, 30)


                    VStack(alignment: .leading, spacing: 8){

                        Text("Email Address")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top, 10)
                        TextField("", text: self.$logInVM.email)
                            .foregroundColor(Color("darkNeutral"))
                            .disableAutocorrection(true)
                        Divider()

                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.gray)
                        HStack {
                            if logInVM.showPassword {
                                TextField("", text: self.$logInVM.password)
                                    .foregroundColor(Color("darkNeutral"))
                                    .disableAutocorrection(true)
                            }
                            else {
                                SecureField("", text: self.$logInVM.password)
                                    .foregroundColor(Color("darkNeutral"))
                            }
                            Button(action: {
                                logInVM.showPassword.toggle()
                            }, label: {
                                Image(systemName: logInVM.showPassword ? "eye.slash" : "eye")
                            })
                            .foregroundColor(Color("darkNeutral"))
                        }

                        Divider()
                            .padding(.bottom, 15)

                        //Buttons
                        VStack(alignment: .center, spacing: 0) {
                            Button(action: {
                                logInVM.logInWithEmailPassword {
                                    print("user successfully signed in")
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Log In")
                                        .fontWeight(.semibold)
                                        .font(.body)
                                        .foregroundColor(.white)
                                        .padding(10)
                                    Spacer()
                                }
                                .background(
                                    logInVM.email == "" || logInVM.password == "" ? Color.gray.cornerRadius(18) : Color("primary").cornerRadius(18)
                                )
                            })
                            Button(action: {
                                //logInVM.forgotPassword()
                            }, label: {
                                Text("Forgot Password?")
                                    .fontWeight(.semibold)
                                    .font(.footnote)
                                    .foregroundColor(Color("darkNeutral"))
                                    .padding()
                            })
                        }

                    }
                    .padding()
                    .background(
                        Color.white
                            .cornerRadius(10)
                            .shadow(color: .gray.opacity(0.2), radius: 8, x: 3, y: 3)
                    )
                    .padding(.horizontal, 25)
                    .padding(.bottom, 10)

                    Text("Version 1.0")
                        .font(.caption)
                        .foregroundColor(Color("darkNeutral"))
                    Spacer()
                }
                HStack {
                    Button(action: {
                        self.logInVM.clearFields()
                        withAnimation{self.logInVM.login.toggle()}
                    }, label: {
                        Text("Sign up")
                            .font(.callout)
                            .foregroundColor(Color("darkNeutral"))
                            .padding()

                    })
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Cancel")
                            .font(.callout)
                            .foregroundColor(Color("darkNeutral"))
                            .padding()

                    })
                }

            }
            .animation(.spring())
            .offset(x: self.logInVM.login ? 0 : UIScreen.main.bounds.width)
            
            //Sign up Screen
            ZStack(alignment: .topTrailing){
                ScrollView {
                    VStack(alignment: .center, spacing: 0){
                        HStack {
                            VStack(alignment: .leading) {
                                Text("YourLife.")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .foregroundColor(Color("primary"))
                                    
                                Text("YourHealth.")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .foregroundColor(Color("primary"))
                                    
                                Text("YourYogi.")
                                    .fontWeight(.bold)
                                    .font(.title)
                                    .foregroundColor(Color("primary"))
                                    .padding(.bottom, 30)
                            }
                            
                            Spacer()
                            
                            LottieView(name: "signupAnimation")
                                .frame(height: UIScreen.main.bounds.height / 3)
                        }
                        .padding(.leading, 25)
                        
                        
                        VStack(alignment: .leading, spacing: 5){
                            Text("First Name")
                                .font(.caption)
                                .foregroundColor(Color("darkNeutral"))
                                .padding(.top, 13)
                                .padding(.leading, 13)
                            TextField("", text: self.$logInVM.firstName)
                                .font(.callout)
                                .foregroundColor(Color("darkNeutral"))
                                .disableAutocorrection(true)
                                .padding(.bottom, 5)
                                .padding(.leading, 13)
                            Divider()
                                .padding(.horizontal, 13)
                            Text("Last Name")
                                .font(.caption)
                                .foregroundColor(Color("darkNeutral"))
                                .padding(.top, 13)
                                .padding(.leading, 13)
                            TextField("", text: self.$logInVM.lastName)
                                .font(.callout)
                                .foregroundColor(Color("darkNeutral"))
                                .disableAutocorrection(true)
                                .padding(.bottom, 5)
                                .padding(.leading, 13)
                            Divider()
                                .padding(.horizontal, 13)
                            Text("Goals for YourYogi")
                                .font(.caption)
                                .foregroundColor(Color("darkNeutral"))
                                .padding(.top, 13)
                                .padding(.leading, 13)
                            TextEditor(text: self.$logInVM.goals)
                                .font(.callout)
                                .foregroundColor(Color("darkNeutral"))
                                .frame(height: 80)
                                .colorMultiply(Color("lightNeutral"))
                                .padding(.bottom, 13)
                                .padding(.horizontal, 13)
                        }
                        .background(Color("lightNeutral").cornerRadius(8))
                        .padding(.bottom)
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("Email Address")
                                .font(.caption)
                                .foregroundColor(Color("darkNeutral"))
                                .padding(.top, 13)
                                .padding(.leading, 13)
                            TextField("Enter your email", text: self.$logInVM.email)
                                .font(.callout)
                                .foregroundColor(Color("darkNeutral"))
                                .disableAutocorrection(true)
                                .padding(.bottom, 13)
                                .padding(.leading, 13)
                        }
                        .background(Color("lightNeutral").cornerRadius(8))
                        .padding(.horizontal)
                        
                        HStack(alignment: .center){
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text("Password")
                                    .font(.caption)
                                    .foregroundColor(Color("darkNeutral"))
                                    .padding(.top, 13)
                                    .padding(.leading, 13)
                                
                                if logInVM.showPassword {
                                    TextField("Create a password", text: self.$logInVM.password)
                                        .font(.callout)
                                        .foregroundColor(Color("darkNeutral"))
                                        .disableAutocorrection(true)
                                        .padding(.bottom, 13)
                                        .padding(.leading, 13)
                                }
                                else {
                                    SecureField("Create a password", text: self.$logInVM.password)
                                        .font(.callout)
                                        .foregroundColor(Color("darkNeutral"))
                                        .padding(.bottom, 13)
                                        .padding(.leading, 13)
                                }
                                
                            }
                            
                            Button(action: {
                                logInVM.showPassword.toggle()
                            }, label: {
                                Image(systemName: logInVM.showPassword ? "eye.slash" : "eye")
                                    .padding(.trailing, 13)
                            })
                            .foregroundColor(Color("darkNeutral"))
                        }
                        .background(Color("lightNeutral").cornerRadius(8))
                        .padding()
                        
                        Button(action: {
                            self.logInVM.signUpWithEmailPassword{
                                print("User signed up successfully")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Sign Up")
                                    .fontWeight(.semibold)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(13)
                                Spacer()
                            }
                            .background(
                                logInVM.fieldsNotFilled() ? Color.gray.cornerRadius(18) : Color("primary").cornerRadius(18)
                            )
                        })
                        .padding()
                        Spacer()
                    }
                }
                
                Button(action: {
                    self.logInVM.clearFields()
                    withAnimation{self.logInVM.login.toggle()}
                }, label: {
                    Text("Log in")
                        .font(.callout)
                        .foregroundColor(Color("darkNeutral"))
                        .padding()

                })

            }
            .animation(.spring())
            .offset(x: self.logInVM.login ? -UIScreen.main.bounds.width : 0)
        }
        .accentColor(Color("primary"))
        
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
