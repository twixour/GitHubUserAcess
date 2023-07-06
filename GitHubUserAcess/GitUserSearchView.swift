//
//  GitUserSearchView.swift
//  GitHubUserAcess
//
//  Created by Raushan Kashyap on 06/07/23.
//

import SwiftUI

struct GitUserSearchView: View {
    @Binding var profileName: String
    @Binding var user: GitHubUser?
    
    var body: some View {
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
    }
}

struct GitUserSearchView_Previews: PreviewProvider {
//    var gUser: GitHubUser? = GitHubUser(login: "", avatarUrl: "", bio: "")
    static var previews: some View {
        GitUserSearchView(profileName: .constant("twixour"), user: .constant(GitHubUser(login: "", avatarUrl: "", bio: "")))
    }
}
