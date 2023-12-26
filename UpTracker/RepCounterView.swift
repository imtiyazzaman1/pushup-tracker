import SwiftUI
import ARKit

class PressUpCounterViewModel: ObservableObject {
    @Published var pressUpCount: Int = 0
}

class AppViewModel: ObservableObject {
    @Published var pressUpCounterViewModel = PressUpCounterViewModel()
}

struct ARViewContainer: UIViewControllerRepresentable {
    @EnvironmentObject var appViewModel: AppViewModel
    @Binding var viewModel: PressUpCounterViewModel

    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController()
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        // Set the viewModel property when the view appears
        uiViewController.viewModel = viewModel
    }
}

struct RepCounterView: View {
    @StateObject private var appViewModel = AppViewModel()
    @State private var arViewModel = PressUpCounterViewModel()

    var body: some View {
        ZStack {
            ARViewContainer(viewModel: $arViewModel)
                .environmentObject(appViewModel)
                .onAppear {
                    // Set the AppViewModel's viewModel
                    appViewModel.pressUpCounterViewModel = arViewModel
                }
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                PressUpCounterView(viewModel: appViewModel.pressUpCounterViewModel)
            }
        }
    }
}

struct PressUpCounterView: View {
    @ObservedObject var viewModel: PressUpCounterViewModel

    var body: some View {
        Text("Press Up Count: \(viewModel.pressUpCount)")
            .foregroundColor(.white)
            .font(.headline)
            .padding()
    }
}


class ARViewController: UIViewController, ARSessionDelegate {
    private var arView: ARSCNView! = ARSCNView()
    private var session: ARSession!
    var viewModel: PressUpCounterViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        arView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(arView)

        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

        session = ARSession()
        session.delegate = self

        // Assign the viewModel to update the pressUpCount
        viewModel = (UIApplication.shared.delegate as? AppDelegate)?.viewModel
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARFaceTrackingConfiguration()
        print("running session!")
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        session.pause()
    }

    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        guard let faceAnchor = anchors.first as? ARFaceAnchor else {
            return
        }
        
        
        print("in the session!")
        print(faceAnchor)

        let leftEyePosition = faceAnchor.leftEyeTransform.columns.3
        let rightEyePosition = faceAnchor.rightEyeTransform.columns.3

        let distanceBetweenEyes = simd_distance(leftEyePosition, rightEyePosition)

        // Now, use the distance information to increment your press-up counter
        print(distanceBetweenEyes)
        updatePressUpCounter(distance: distanceBetweenEyes)
    }

    func updatePressUpCounter(distance: Float) {
        // Implement your logic to update the press-up counter based on the distance
        // For demonstration purposes, let's increment the counter for every rep
        if distance < 0.05 { // Adjust the threshold as needed
            print("threshold met!")
            viewModel?.pressUpCount += 1
            print("Press Up Count: \(viewModel?.pressUpCount ?? 0)")
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    var viewModel = PressUpCounterViewModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Create a window and set the root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UIHostingController(rootView: RepCounterView())
        window?.makeKeyAndVisible()
        return true
    }
}

