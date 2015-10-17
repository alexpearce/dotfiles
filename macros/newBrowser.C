#include <TApplication.h>
#include <TBrowser.h>

void newBrowser();
int main(int argc, char *argv[]);

// Open a TBrowser
// Use like
//   $ root -l file1.root file2.root ... newBrowser.C
void newBrowser() {
  char *argv = new char[0];
  main(0, &argv);
}

int main(int argc, char *argv[]) {
  TApplication *app = gApplication;
  bool ownApp = false;
  if (!app) {
    ownApp = true;
    app = new TApplication("app", &argc, argv);
  }
  TBrowser *browser = new TBrowser;
  if (ownApp) {
    app->Run();
  }
  return 0;
}
