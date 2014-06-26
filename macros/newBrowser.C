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
  TBrowser *browser = new TBrowser;
  return 0;
}
