//
//  TaskMasterWidget.swift
//  TaskMasterWidget
//
//  Created by Sravanthi Chinthireddy on 06/03/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, emoji: "😀")
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct TaskMasterWidgetEntryView : View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var widgetFamily
    
    var fontStyle: Font {
        if widgetFamily == .systemSmall {
            return .system(.footnote, design: .rounded)
        }
        else {
            return .system(.headline, design: .rounded)
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
//                backgroundGradient
                
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .frame(
                        width: widgetFamily != .systemSmall ? 56 : 36,
                        height: widgetFamily != .systemSmall ? 56 : 36)
                    .offset(x:geometry.size.width / 2 - 20,
                            y:geometry.size.height / -2 + 20)
                    .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
                
                HStack {
                    
                    Text("Let's Do It")
                        .foregroundStyle(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(.black)
                        .opacity(0.5)
                    .clipShape(Capsule())
                    
                    if widgetFamily != .systemSmall {
                        Spacer()
                    }
                }
                .padding()
                .offset(y: geometry.size.height / 2 - 25)
            }
        }
    }
}

struct TaskMasterWidget: Widget {
    let kind: String = "TaskMasterWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                TaskMasterWidgetEntryView(entry: entry)
                    .containerBackground(backgroundGradient, for: .widget)
            } else {
                TaskMasterWidgetEntryView(entry: entry)
                    .padding()
                    .background(backgroundGradient)
            }
        }
        .configurationDisplayName("Task Master Launcher")
        .description("This is an example widget for To-Do list app.")
    }
}

#Preview(as: .systemMedium) {
    TaskMasterWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
}

