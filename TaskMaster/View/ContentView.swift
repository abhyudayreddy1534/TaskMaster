//
//  ContentView.swift
//  TaskMaster
//
//  Created by Sravanthi Chinthireddy on 05/03/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @State var task: String = ""
    @State var showNewTaskItem: Bool = false
        
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    HStack(spacing: 10) {
                        Text("Task Master")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule().stroke(.white, lineWidth: 2)
                            )
                        
                        Button(action: {
                            isDarkMode.toggle()
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                    }
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer(minLength: 80)
                    
                    Button {
                        showNewTaskItem = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(LinearGradient(colors: [Color.pink, Color.blue],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                        .clipShape(Capsule()))
                    .shadow(radius: 10)
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
//                            for navigation linking
//                            NavigationLink {
//                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                            } label: {
//                                VStack(alignment: .leading) {
//                                    Text(item.task ?? "")
//                                        .font(.headline)
//                                        .fontWeight(.bold)
//                                    Text(item.timestamp!, formatter: itemFormatter)
//                                        .font(.footnote)
//                                        .foregroundStyle(.gray)
//                                }
//                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
//                    This is very important to make the background work, otherwise it wn;t work
                    .scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(radius: 10)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                }
                .blur(radius: showNewTaskItem ? 10 : 0, opaque: false)
                .transition(.move(edge: .bottom))
//                .animation(.easeInOut(duration: 0.5), value: showNewTaskItem)
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? Color.black : Color.gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5
                    )
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
////                    Button(action: addItem) {
////                        Label("Add Item", systemImage: "plus")
////                    }
//                }
//            }
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 10 : 0, opaque: false)
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all)
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - Functions
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
