//
//  GitHubUserView.swift
//  GitHubUserAcess
//
//  Created by Raushan Kashyap on 06/07/23.
//

import SwiftUI

struct GitHubUserView: View {
    @State private var user: GitHubUser?
    @State private var profileName: String = "twixour"
    
    var body: some View {
        VStack {
            VStack {
                Text("Username")
                    .font(.title2)
                    .fontWeight(.heavy)
                
                HStack {
                    TextField("twixour", text: $profileName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20.0)
                        .shadow(radius: 2, x:2, y: 2)
                        .shadow(radius: 2, x:-2, y: -2)
                        .disableAutocorrection(true)
                        .onSubmit {
                            Task {
                                do {
                                    user = try await getUser(username: profileName)
                                } catch GHError.invalidURL {
                                    print("invalid URL")
                                } catch GHError.invalidResponse {
                                    print("invalid response")
                                } catch GHError.invalidData {
                                    print("invalid data")
                                } catch {
                                    print("Unexpected Error")
                                }
                            }
                        }
                    Button(action:{
                        Task {
                            do {
                                user = try await getUser(username: profileName)
                            } catch GHError.invalidURL {
                                print("invalid URL")
                            } catch GHError.invalidResponse {
                                print("invalid response")
                            } catch GHError.invalidData {
                                print("invalid data")
                            } catch {
                                print("Unexpected Error")
                            }
                        }
                    }) {
                        Text("Submit")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width:100, height: 50)
                            .background(Color.green)
                            .cornerRadius(15.0)
                            .shadow( radius: 2, x:2, y: 2)
                            .shadow(radius: 2, x:-2, y: -2)
                    }
                }
            }
            .padding()
            
            VStack {
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) {image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 6))
                        .shadow(radius:10)
                } placeholder: {
                    Circle()
                        .foregroundColor(.secondary)
                }
                .frame(width:120, height:120)
                
                Text(user?.login ?? "username")
                    .bold()
                    .font(.title3)
                Text(user?.bio ?? "bio")
                    .padding()
                Spacer()
            }
            .padding()
            .task {
                do {
                    user = try await getUser(username: profileName)
                } catch GHError.invalidURL {
                    print("invalid URL")
                } catch GHError.invalidResponse {
                    print("invalid response")
                } catch GHError.invalidData {
                    print("invalid data")
                } catch {
                    print("Unexpected Error")
                }
            }
        }
    }
}

struct GitHubUserView_Previews: PreviewProvider {
    static var previews: some View {
        GitHubUserView()
    }
}
