#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <windows.h>
#include <shellapi.h>  // Include Shell API for ShellExecute

using namespace flutter;

void OpenCamera() {
    // Command to open the default Windows camera application
    ShellExecute(NULL, L"open", L"ms-camera:", NULL, NULL, SW_SHOWNORMAL);
}

void RegisterPlugins(flutter::PluginRegistry* registry) {
    auto channel = std::make_unique<MethodChannel<EncodableValue>>(
            registry->GetRegistrarForPlugin("com.example.camera"),
                    "com.example.camera",
                    &StandardMethodCodec::GetInstance());

    channel->SetMethodCallHandler([](const MethodCall<EncodableValue>& call,
                                     std::unique_ptr<MethodResult<EncodableValue>> result) {
        if (call.method_name().compare("openCamera") == 0) {
            OpenCamera();
            result->Success();
        } else {
            result->NotImplemented();
        }
    });
}

int APIENTRY wWinMain(HINSTANCE instance, HINSTANCE prev, LPWSTR lpCmdLine, int nCmdShow) {
// Initialize the Flutter engine
flutter::DartProject project(L"data");
flutter::FlutterViewController controller(0, project);
RegisterPlugins(controller.GetPluginRegistry());

// Run the app
controller.Run();
return 0;
}
