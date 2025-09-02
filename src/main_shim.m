@import Darwin;
@import Foundation;

int (*main_ui)(int argc, char *argv[], char *envp[]);

int main(int argc, char *argv[], char *envp[]) {
    // bypass _NSCheckForIllegalSetugidApp by setting egid to 90 (accessibility)
    setreuid(0, 0);
    setregid(0, getgrnam("accessibility")->gr_gid);
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *ccuiPath = [bundle.privateFrameworksPath stringByAppendingPathComponent:@"CocoaTopUI.framework/CocoaTopUI"];
    void *handle = dlopen(ccuiPath.fileSystemRepresentation, RTLD_GLOBAL);
    assert(handle != NULL);
    main_ui = dlsym(handle, "main_ui");
    return main_ui(argc, argv, envp);
}
