import Foundation

struct Service: Identifiable, Hashable {
    let id = UUID()
    let titleEN: String
    let titleAR: String
    let descriptionEN: String
    let descriptionAR: String

    func title(isArabic: Bool) -> String {
        isArabic ? titleAR : titleEN
    }

    func description(isArabic: Bool) -> String {
        isArabic ? descriptionAR : descriptionEN
    }
}

enum AppConstants {
    static let logoURL = URL(string: "https://grandwolfeg.com/wp-content/uploads/2026/03/Grand-wolf-Final-2048x861.png")!
    static let heroURL = URL(string: "https://grandwolfeg.com/app/hero-1_mobile.jpg")!

    static let phone = "+201000064638"
    static let email = "Info@grandwolfeg.com"

    static let whatsappInternational = "201000064638"

    static let facebookURL = URL(string: "https://www.facebook.com/grandwolfeg")!
    static let instagramURL = URL(string: "https://www.instagram.com/grandwolfeg")!
    static let linkedinURL = URL(string: "https://www.linkedin.com/company/grandwolfeg")!
}

enum LocalizedText {
    static let home = (en: "Home", ar: "الرئيسية")
    static let services = (en: "Services", ar: "الخدمات")
    static let request = (en: "Request", ar: "طلب خدمة")
    static let contact = (en: "Contact", ar: "اتصل بنا")
    static let more = (en: "More", ar: "المزيد")
}

extension Array where Element == Service {
    static let grandWolfServices: [Service] = [
        .init(titleEN: "Land Guarding", titleAR: "حراسة المنشآت", descriptionEN: "Personnel and technology integration.", descriptionAR: "دمج الأفراد مع التقنيات الحديثة."),
        .init(titleEN: "Hotel Security", titleAR: "أمن الفنادق", descriptionEN: "Tourism site specialized protection.", descriptionAR: "حماية متخصصة للمواقع السياحية."),
        .init(titleEN: "Office Security", titleAR: "أمن المكاتب", descriptionEN: "Access management and logging.", descriptionAR: "إدارة الدخول وتسجيل التحركات."),
        .init(titleEN: "Private Guards", titleAR: "حراسة خاصة", descriptionEN: "VIP and high-profile protection.", descriptionAR: "حماية الشخصيات الهامة وكبار الزوار."),
        .init(titleEN: "Monitoring", titleAR: "أنظمة المراقبة", descriptionEN: "Professional tracking systems.", descriptionAR: "أنظمة تتبع ومراقبة احترافية."),
        .init(titleEN: "Factory Security", titleAR: "أمن المصانع", descriptionEN: "Material and vehicle control.", descriptionAR: "التحكم في المواد والمركبات."),
        .init(titleEN: "Diplomatic", titleAR: "أمن البعثات", descriptionEN: "High-safety protection plans.", descriptionAR: "خطط حماية عالية الأمان."),
        .init(titleEN: "Yacht Security", titleAR: "أمن اليخوت", descriptionEN: "Tailored cruise operations.", descriptionAR: "عمليات مخصصة للرحلات البحرية."),
        .init(titleEN: "Event Security", titleAR: "تأمين الفعاليات", descriptionEN: "Crowd control and coordination.", descriptionAR: "إدارة الحشود والتنسيق الميداني."),
        .init(titleEN: "Training", titleAR: "التدريب", descriptionEN: "Security operations practical training.", descriptionAR: "تدريب عملي لعمليات الأمن."),
        .init(titleEN: "Oil & Gas", titleAR: "البترول والغاز", descriptionEN: "Critical asset protection.", descriptionAR: "حماية الأصول الحيوية."),
        .init(titleEN: "Cash Transport", titleAR: "نقل الأموال", descriptionEN: "Secure logistics and valuables.", descriptionAR: "نقل آمن للوجستيات والمقتنيات الثمينة.")
    ]
}
