import SwiftUI

final class AppState: ObservableObject {
    @Published var isArabic = false
    let services = [Service].grandWolfServices

    func t(_ pair: (en: String, ar: String)) -> String {
        isArabic ? pair.ar : pair.en
    }
}

enum RootTab: Hashable {
    case home
    case services
    case request
    case contact
    case more
}

struct RootTabView: View {
    @EnvironmentObject private var appState: AppState
    @State private var selection: RootTab = .home

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Label(appState.t(LocalizedText.home), systemImage: "house.fill")
                }
                .tag(RootTab.home)

            ServicesView()
                .tabItem {
                    Label(appState.t(LocalizedText.services), systemImage: "shield.fill")
                }
                .tag(RootTab.services)

            RequestServiceView()
                .tabItem {
                    Label(appState.t(LocalizedText.request), systemImage: "plus.circle.fill")
                }
                .tag(RootTab.request)

            ContactView()
                .tabItem {
                    Label(appState.t(LocalizedText.contact), systemImage: "questionmark.circle.fill")
                }
                .tag(RootTab.contact)

            MoreView()
                .tabItem {
                    Label(appState.t(LocalizedText.more), systemImage: "ellipsis.circle.fill")
                }
                .tag(RootTab.more)
        }
        .tint(.gwAccentGold)
        .background(Color.gwLightBackground.ignoresSafeArea())
    }
}

struct HomeView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            AsyncImage(url: AppConstants.heroURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    Color.gwPrimaryDark
                }
            }
            .ignoresSafeArea()

            Color.black.opacity(0.45).ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()
                AsyncImage(url: AppConstants.logoURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 280)
                    default:
                        ProgressView()
                            .tint(.white)
                    }
                }

                Text(appState.isArabic ? "الأمن ونقل الأموال" : "Security & Cash Transport")
                    .foregroundColor(.gwAccentGold)
                    .font(.system(size: 42, weight: .bold, design: .condensed))
                    .multilineTextAlignment(.center)

                Text(appState.isArabic ? "حماية احترافية لأصولك وراحة بالك" : "Elite protection for your assets and peace of mind.")
                    .foregroundColor(.white)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button {
                    openPhoneCall()
                } label: {
                    Label(appState.isArabic ? "اتصل للاستفسار" : "Call for Inquiry", systemImage: "phone.fill")
                        .font(.title3.bold())
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gwAccentGold)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                Button {
                    openWhatsApp(message: appState.isArabic ? "مرحبًا، أريد الاستفسار عن خدماتكم" : "Hello, I would like to inquire about your services")
                } label: {
                    Label(appState.isArabic ? "راسلنا واتساب" : "WhatsApp Us", systemImage: "message.fill")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gwWhatsAppGreen)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                Spacer()
            }
            .padding()
        }
    }
}

struct ServicesView: View {
    @EnvironmentObject private var appState: AppState
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(appState.services) { service in
                        VStack(spacing: 12) {
                            Circle()
                                .fill(Color.gwAccentGold.opacity(0.15))
                                .frame(width: 44, height: 44)
                                .overlay {
                                    Image(systemName: "shield.lefthalf.filled")
                                        .foregroundStyle(Color.gwAccentGold)
                                }

                            Text(service.title(isArabic: appState.isArabic))
                                .font(.headline)
                                .foregroundStyle(Color.gwPrimaryDark)
                                .multilineTextAlignment(.center)

                            Text(service.description(isArabic: appState.isArabic))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity, minHeight: 170)
                        .padding()
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
                    }
                }
                .padding()
            }
            .background(Color.gwLightBackground)
            .navigationTitle(appState.t(LocalizedText.services).uppercased())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RequestServiceView: View {
    @EnvironmentObject private var appState: AppState

    @State private var fullName = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var company = ""
    @State private var selectedService = ""
    @State private var details = ""
    @State private var showValidation = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    inputField(title: appState.isArabic ? "الاسم الكامل" : "Full Name", value: $fullName)
                    inputField(title: appState.isArabic ? "الهاتف" : "Phone", value: $phone, keyboard: .phonePad)
                    inputField(title: appState.isArabic ? "البريد الإلكتروني" : "Email", value: $email, keyboard: .emailAddress)
                    inputField(title: appState.isArabic ? "الشركة" : "Company", value: $company)

                    Picker(appState.isArabic ? "الخدمة المطلوبة" : "Service Needed", selection: $selectedService) {
                        Text(appState.isArabic ? "اختر خدمة" : "Select a service").tag("")
                        ForEach(appState.services) { service in
                            Text(service.title(isArabic: appState.isArabic)).tag(service.titleEN)
                        }
                    }
                    .pickerStyle(.menu)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.5)))

                    VStack(alignment: .leading, spacing: 8) {
                        Text(appState.isArabic ? "التفاصيل والمتطلبات" : "Details & Requirements")
                            .foregroundStyle(.secondary)
                        TextEditor(text: $details)
                            .frame(height: 150)
                    }
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.5)))

                    if showValidation {
                        Text(appState.isArabic ? "يرجى استكمال البيانات المطلوبة" : "Please fill all required fields.")
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button {
                        submitRequest()
                    } label: {
                        Text(appState.isArabic ? "إرسال الطلب عبر البريد" : "Submit Request via Email")
                            .font(.title3.bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(Color.gwPrimaryDark)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding()
            }
            .background(Color.gwLightBackground)
            .navigationTitle(appState.t(LocalizedText.request).uppercased())
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func inputField(title: String, value: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        TextField(title, text: value)
            .keyboardType(keyboard)
            .textInputAutocapitalization(.words)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.5)))
    }

    private func submitRequest() {
        let trimmedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedService = selectedService.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty, !trimmedPhone.isEmpty, !trimmedService.isEmpty else {
            showValidation = true
            return
        }

        showValidation = false

        let body = """
        Name: \(fullName)
        Phone: \(phone)
        Email: \(email)
        Company: \(company)
        Service: \(selectedService)
        Details: \(details)
        """

        let subject = appState.isArabic ? "طلب خدمة جديد" : "New Service Request"

        var components = URLComponents()
        components.scheme = "mailto"
        components.path = AppConstants.email
        components.queryItems = [
            URLQueryItem(name: "subject", value: subject),
            URLQueryItem(name: "body", value: body)
        ]

        guard let emailURL = components.url else { return }
        UIApplication.shared.open(emailURL)
    }
}

struct ContactView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    contactCard(icon: "phone.fill", title: appState.isArabic ? "اتصال" : "Phone Inquiry", subtitle: AppConstants.phone) {
                        openPhoneCall()
                    }

                    contactCard(icon: "envelope.fill", title: appState.isArabic ? "البريد الإلكتروني" : "Email Us", subtitle: AppConstants.email) {
                        openEmail()
                    }

                    contactCard(icon: "f.square.fill", title: "Facebook", subtitle: "Follow us") {
                        UIApplication.shared.open(AppConstants.facebookURL)
                    }

                    contactCard(icon: "camera.fill", title: "Instagram", subtitle: "Follow us") {
                        UIApplication.shared.open(AppConstants.instagramURL)
                    }

                    contactCard(icon: "link", title: "LinkedIn", subtitle: "Follow us") {
                        UIApplication.shared.open(AppConstants.linkedinURL)
                    }

                    contactCard(icon: "message.fill", title: "WhatsApp", subtitle: appState.isArabic ? "راسلنا الآن" : "Message us now", bg: .gwWhatsAppGreen, fg: .white) {
                        openWhatsApp(message: appState.isArabic ? "مرحبًا" : "Hello")
                    }
                }
                .padding()
            }
            .background(Color.gwLightBackground)
            .navigationTitle(appState.t(LocalizedText.contact).uppercased())
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func contactCard(icon: String, title: String, subtitle: String, bg: Color = .white, fg: Color = .gwPrimaryDark, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .frame(width: 28)
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(.headline)
                    Text(subtitle).font(.footnote).foregroundStyle(fg.opacity(0.75))
                }
                Spacer()
            }
            .foregroundStyle(fg)
            .padding()
            .background(bg)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.2)))
        }
    }
}

struct MoreView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                Text(appState.isArabic ? "الإعدادات" : "Settings")
                    .font(.largeTitle.bold())

                HStack {
                    Label(appState.isArabic ? "اللغة العربية" : "Arabic Language", systemImage: "globe")
                        .font(.title2)
                        .foregroundStyle(.gwPrimaryDark)

                    Spacer()

                    Toggle("", isOn: $appState.isArabic)
                        .labelsHidden()
                        .tint(.gwAccentGold)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 22))
                .shadow(color: .black.opacity(0.06), radius: 6, y: 3)

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.gwLightBackground)
            .navigationTitle(appState.t(LocalizedText.more).uppercased())
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private func openPhoneCall() {
    let raw = AppConstants.phone.replacingOccurrences(of: " ", with: "")
    guard let url = URL(string: "tel://\(raw)") else { return }
    UIApplication.shared.open(url)
}

private func openEmail() {
    guard let url = URL(string: "mailto:\(AppConstants.email)") else { return }
    UIApplication.shared.open(url)
}

private func openWhatsApp(message: String) {
    let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    let urlString = "https://wa.me/\(AppConstants.whatsappInternational)?text=\(encodedMessage)"
    guard let url = URL(string: urlString) else { return }
    UIApplication.shared.open(url)
}
