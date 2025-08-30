import SwiftUI

// MARK: - Dashboard
struct Dashboard: View {
    
    private let testIcons = ["ic-add", "ic-wind", "ic-tv", "ic-speaker", "ic-light"]
    @State private var isOn = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // Weather header
                WeatherHeaderView(iconName: "ic-sunny", temperature: "Sunny, 24°C", location: "Stockholm, Sweden")
                    .padding(.top, 20)
                
                // Devices section
                Text("Your Devices")
                    .font(.headline)
                    .padding(.top, 60)
                
                DeviceListView(iconNames: testIcons)
                
                // Air Conditioner Cards layout
                HStack(alignment: .top, spacing: 20) {
                    
                    AirConditionerCard(isOn: $isOn)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                    
                    VStack(spacing: 10) {
                        SmallDeviceCard(title: "Speaker", location: "Bedroom", iconName: "ic-speaker", isOn: $isOn)
                        SmallDeviceCard(title: "Smart TV", location: "Living Room", iconName: "ic-tv", isOn: $isOn)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                }
                
                // Single device row
                DeviceRow(title: "Speaker", location: "Bedroom", iconName: "ic-light", isOn: $isOn)
                
                Spacer()
            }
            .padding()
        }
        .background(Color(hex: "F1F5F9"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MARK: - Weather Header
struct WeatherHeaderView: View {
    let iconName: String
    let temperature: String
    let location: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(iconName)
            VStack(alignment: .leading, spacing: 8) {
                Text(temperature)
                    .font(.system(size: 30))
                    .bold()
                Text(location)
                    .font(.subheadline)
            }
            .padding(.leading, 10)
            Spacer()
        }
    }
}

// MARK: - Device List
struct DeviceListView: View {
    let iconNames: [String]
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            ForEach(Array(iconNames.enumerated()), id: \.element) { index, iconName in
                DeviceButton(iconName: iconName, isFirst: index == 0)
            }
        }
    }
}

struct DeviceButton: View {
    let iconName: String
    let isFirst: Bool
    
    var body: some View {
        Button(action: { print("\(iconName) tapped") }) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .padding(isFirst ? 0 : 20)
                .background(Circle().fill(Color.white))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Air Conditioner Card
struct AirConditionerCard: View {
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ImageButtonToggle(isOn: $isOn, iconName: "ic-wind")
                .padding([.top, .horizontal], 10)
            
            Text("Air Conditioner").bold().padding(.leading, 10)
            Text("Entrance").foregroundColor(.gray).padding(.leading, 10)
            
            Divider().padding(.horizontal, 10)
            
            Text("23°C").bold().padding(.leading, 10)
            Text("Mode: Auto").foregroundColor(.gray).padding(.leading, 10)
            
            HStack(spacing: 10) {
                StepperButton(icon: "minus")
                StepperButton(icon: "plus")
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 20)
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Small Device Card (VStack)
struct SmallDeviceCard: View {
    let title: String
    let location: String
    let iconName: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ImageButtonToggle(isOn: $isOn, iconName: iconName)
                .padding([.top, .horizontal], 10)
            
            Text(title).bold().padding(.leading, 10)
            Text(location).foregroundColor(.gray).padding(.leading, 10)
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Device Row (HStack with Toggle)
struct DeviceRow: View {
    let title: String
    let location: String
    let iconName: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .padding(10)
                .background(Circle().fill(Color(hex: "F1F5F9")))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title).bold()
                Text(location).foregroundColor(.gray).font(.subheadline)
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - Image + Toggle
struct ImageButtonToggle: View {
    @Binding var isOn: Bool
    let iconName: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .padding(10)
                .background(Circle().fill(Color(hex: "F1F5F9")))
                .frame(width: 50, height: 50)
            
            Toggle("", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .orange))
        }
    }
}

// MARK: - Stepper Button
struct StepperButton: View {
    let icon: String
    
    var body: some View {
        Button(action: { print("\(icon) tapped") }) {
            Image(systemName: icon)
                .foregroundColor(.black)
                .scaledToFit()
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(Color(hex: "F1F5F9"))
                .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Preview
struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
