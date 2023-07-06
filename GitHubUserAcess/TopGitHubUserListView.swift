//
//  TopGitHubUserListView.swift
//  GitHubUserAcess
//
//  Created by Raushan Kashyap on 06/07/23.
//

import SwiftUI

struct TopGitHubUserListView: View {
    @Binding var showTopGitUserListView: Bool
    
    @Binding var profileName: String
    @Binding var user: GitHubUser?
    
    let gitUsers = topGitUsersList
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack {
                VStack {
                    Text("List of Top Users")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding()
                }
                .padding()
                VStack {
                    ForEach(gitUsers, id:\.self) { userName in
                        Button(action: {
                            showTopGitUserListView = false
                            Task {
                                do {
                                    user = try await getUser(username: userName)
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
                            Text(userName)
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .padding()
                                .frame(width:180, height: 50)
                                .background(Color.green)
                                .cornerRadius(15.0)
                                .shadow( radius: 2, x:2, y: 2)
                                .shadow(radius: 2, x:-2, y: -2)
                        }
                    }
                }
                .padding()
                
            }
            
            Button(action: {
                showTopGitUserListView.toggle()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    .padding(.trailing)
            }
            .padding(.bottom, 80)
            
        
        }
    }
}

struct TopGitHubUserListView_Previews: PreviewProvider {
    static var previews: some View {
        TopGitHubUserListView(showTopGitUserListView: .constant(true),profileName: .constant("twixour"), user: .constant(GitHubUser(login: "", avatarUrl: "", bio: "")))
    }
}




//        ZStack(alignment: .topTrailing) {
//            NavigationView{
//                List{
//                    ForEach(gitUsers, id:\.self) {user in
//                        NavigationLink(destination: GitHubUserView()) {
//                            Text(user)
//                        }
//
//
//                        .padding()
//                    }
//                    .navigationTitle("List of Top Users")
//                }
//            }
//
//            Button(action: {
//                showTopGitUserListView.toggle()
//            }) {
//                Image(systemName: "xmark.circle")
//                    .font(.title)
//                    .padding(.trailing)
//            }
//        }
