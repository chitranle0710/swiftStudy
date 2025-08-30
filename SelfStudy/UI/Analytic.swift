import SwiftUI

struct Analytic: View {
    private let months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ]
    
    @State private var selectedMonth = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MonthSelector(months: months, selectedMonth: $selectedMonth)
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ConsumedCard()
                    ComparedCard()
                    ConsumedTheMostCard()
                }
                .padding(.horizontal)
            }
            Spacer()
        }
        .padding(.top)
        .background(Color(hex: "F1F5F9"))
    }
}

// MARK: - Month Selector

struct MonthSelector: View {
    let months: [String]
    @Binding var selectedMonth: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(months.indices, id: \.self) { index in
                    MonthSelectorItem(
                        title: months[index],
                        isSelected: selectedMonth == index
                    )
                    .onTapGesture { selectedMonth = index }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct MonthSelectorItem: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(isSelected ? .orange : .gray)
            Rectangle()
                .fill(isSelected ? Color.orange : Color.clear)
                .frame(height: 2)
        }
    }
}

// MARK: - Card Background & Header

struct CardBackground<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) { self.content = content() }
    var body: some View {
        content
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(10)
    }
}

struct CardHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title).bold().padding(.leading, 15)
            Spacer()
            Image(systemName: "chevron.right")
                .resizable()
                .scaledToFit()
                .frame(width: 12, height: 12)
                .foregroundColor(.black)
                .padding(.trailing, 15)
        }
        .padding(.top, 15)
    }
}

// MARK: - Consumed Card

struct ConsumedCard: View {
    var body: some View {
        CardBackground {
            VStack(alignment: .leading, spacing: 12) {
                CardHeader(title: "Consumed")
                InfoRow(
                    imageName: "ic-volume",
                    imageBackground: Color(hex: "F1F5F9"),
                    title: "385 kWh",
                    subtitle: "Costs: $22.31"
                )
            }
        }
    }
}

struct InfoRow: View {
    let imageName: String
    let imageBackground: Color
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            Button(action: { }) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .background(Circle().fill(imageBackground))
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(title).bold().padding(.leading, 10)
                Text(subtitle).foregroundColor(Color.gray).padding(.leading, 10)
            }
        }
        .padding(.bottom, 20)
        .padding(.top, 10)
        .buttonStyle(PlainButtonStyle())
        .padding(.leading, 15)
    }
}

// MARK: - Compared to Others Card

struct ComparedCard: View {
    var body: some View {
        CardBackground {
            VStack(alignment: .leading, spacing: 12) {
                CardHeader(title: "Compared to others")
                ForEach(comparedRows, id: \.label) { row in
                    ComparedRow(label: row.label, value: row.value, color: row.color)
                }
                Spacer()
            }
        }
    }
    
    // This can be driven by model/data in future
    var comparedRows: [ComparedRowModel] {
        [
            ComparedRowModel(label: "Most efficient homes", value: "292 kWh", color: .gray),
            ComparedRowModel(label: "Your home", value: "292 kWh", color: .orange),
            ComparedRowModel(label: "Average homes", value: "292 kWh", color: .gray)
        ]
    }
}

struct ComparedRowModel {
    let label: String
    let value: String
    let color: Color
}

struct ComparedRow: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(label).bold().padding(.leading, 15).font(.system(size: 12))
                Spacer()
                Text(value).padding(.trailing, 10).font(.system(size: 12))
            }
            .padding(.top, 10)
            ProgressView(value: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
                .frame(height: 10)
                .padding(.horizontal, 15)
        }
    }
}

// MARK: - Consumed The Most Card

struct ConsumedTheMostCard: View {
    var body: some View {
        CardBackground {
            VStack(alignment: .leading, spacing: 12) {
                CardHeader(title: "Consumed the most")
                ForEach(consumedMostRows, id: \.label) { row in
                    ConsumedMostRow(row: row)
                }
                Spacer()
            }
        }
    }
    
    // This can be driven by model/data in future
    var consumedMostRows: [ConsumedMostRowModel] {
        [
            ConsumedMostRowModel(
                label: "Always on",
                value: "192 kWh",
                imageName: "ic-reload",
                imageBackground: Color(hex: "#DCFCE7"),
                progressColor: Color(hex: "DCFCE7")
            ),
            ConsumedMostRowModel(
                label: "Heating/Cooling",
                value: "192 kWh",
                imageName: "ic-heat",
                imageBackground: Color.orange,
                progressColor: Color.orange
            )
        ]
    }
}

struct ConsumedMostRowModel {
    let label: String
    let value: String
    let imageName: String
    let imageBackground: Color
    let progressColor: Color
}

struct ConsumedMostRow: View {
    let row: ConsumedMostRowModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Button(action: { }) {
                Image(row.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(10)
                    .background(row.imageBackground)
                    .cornerRadius(12)
            }
            .padding(.leading, 10)
            VStack {
                HStack {
                    Text(row.label)
                        .bold()
                        .font(.system(size: 12))
                    Spacer()
                    Text(row.value)
                        .font(.system(size: 12))
                        .padding(.trailing, 10)
                }
                ProgressView(value: 0.5)
                    .progressViewStyle(LinearProgressViewStyle(tint: row.progressColor))
                    .frame(height: 20)
                    .padding(.trailing, 10)
            }
        }
    }
}

// ✅ Previews (for Xcode canvas only)
struct Analytic_Previews: PreviewProvider {
    static var previews: some View {
        Analytic()
    }
}

