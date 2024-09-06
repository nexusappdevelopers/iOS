//
//  ContentView.swift
//  iOS Base
//

import SwiftUI

struct ContentView: View {
    
    //MARKS: VARIABLES
    @StateObject var objViewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if objViewModel.arrUsers.isEmpty {
                    Spacer()
                    ProgressView("Fetching Users")
                    Spacer()
                } else {
                    List(objViewModel.arrUsers,id: \.id) { user in
                        UserDetail(user: user)
                    }
                    .listStyle(.plain)
                    .padding(.top,5)
                }
                Spacer()
            }
            .task {
                await objViewModel.getUsers()
            }
            
        }
        Spacer()
    }
    
    func UserDetail(user:UserModel) -> some View {
        VStack(alignment:.leading){
            Text(user.name)
                .font(.headline)
                .foregroundStyle(Color.black)
            Text(user.username)
                .font(.caption2)
                .foregroundStyle(Color.gray)
        }
    }
    
}

#Preview {
    ContentView()
}
