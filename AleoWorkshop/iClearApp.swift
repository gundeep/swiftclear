

import SwiftUI
import SwiftData

@main
struct AleoWorkshopApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            HealthRecord.self,
            Diagnosis.self,
            Medication.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(AleoManager())
                .environment(LocalAuthenticator())
                .environment(\.colorScheme, .light)
                                .background(Color.green.ignoresSafeArea())
        }
        .modelContainer(sharedModelContainer)
    }
}
