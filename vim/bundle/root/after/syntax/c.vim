" Vim syntax file
" Language:	C/C++ ROOT 
" Maintainer:	Theo Christoudias
" Last Change:	2008 Oct 18
" Remark:	Addon to c.vim (see :help 44.11)
" Remark:	ROOT webite: http://root.cern.ch

if !exists("c_no_cern_root")
   syn keyword	cType		TH1 TH1C TH1D TH1F TH1I TH1K TH1S 
   syn keyword	cType		TH2 TH2C TH2D TH2F TH2I TH2S
   syn keyword	cType		TH3 TH3C TH3D TH3F TH3I TH3S
   syn keyword	cType		TF1 TF2 TF3
   syn keyword	cType		THStack TGraph TGraph2D TCanvas TRandom TLimit TLatex
   syn keyword	cType		TNtuple TObject TTree TIter TKey TRandom2 TShape TPad TMacro
   syn keyword	cType           TString TLine TLegend TFile TDatime TRandom3 TMath
   syn keyword	cType           TLeaf TLeafB TLeafC TLeafD TLeafElement TLeafF TLeafI TLeafL TLeafO TLeafObject
   syn keyword	cType           TChain TDirectory TList TArc TBox TEllipse TPolyLine TCurlyLine TCurlyArc TEllipse
   syn keyword	cType           TMinuit TFitter TLinearFitter TLorentzVector TLorentzRotation TVector3 TVector2
   syn keyword	cType           TRotation TGenPhaseSpace TFeldmanCousins TRobustEstimator TRolke TQuaternion
   syn keyword	cType           TPostScript TSVG TPDF TImageDump THtml TColor TStyle TComplex TPRegexp
   syn keyword	cType           TObjArrayIter TMapIter TClass TEnv TGlobal TCint TROOT TDictionary TTime TTimer
   syn keyword	cType           Double_t Int_t Float_t Long_t Bool_t Byte_t
   syn keyword	cType      	char_t Marker_t Double32_t Float16_t Long64_t
   syn keyword	cType           Short_t Stat_t Style_t Text_t UShort_t  
   syn keyword	cConstant       kRed kPink kBlue kMagenta kViolet kAzure kCyan kTeal kGreen kSpring kYellow
   syn keyword	cConstant       kSolid kDashed kDotted kDashDotted kDot kPlus kStar kCircle kMultiply kFullDotSmall
   syn keyword	cConstant       kFullDotMedium kFullDotLarge kOpenTriangleDown kFullCross kFullCircle kFullSquare
   syn keyword	cConstant       kFullTriangleUp kFullTriangleDown kOpenCircle kOpenSquare kOpenTriangleUp 
   syn keyword	cConstant       kOpenDiamond kOpenCross kFullStar kOpenStar
   syn keyword	cConstant       kTRUE kFALSE 
   syn keyword	cConstant       kIsClass kIsStruct kIsUnion kIsEnum kIsNamespace kIsTypedef kIsFundamental 
   syn keyword	cConstant       kIsAbstract kIsVirtual kIsPureVirtual kIsPublic kIsProtected kIsPrivate kIsPointer 
   syn keyword	cConstant       kIsArray kIsStatic kIsDefault kIsReference kIsConstant kIsConstPointer kIsMethConst
   syn keyword	cSpecial        gGeometry gHistImagePalette gWebImagePalette gGrid gClassTable gObjectTable
   syn keyword	cSpecial        gProof gPerfStats gTQSender gTQSlotParams gDebug gDirectory gROOT gFile gPad 
   syn keyword	cSpecial        gApplication gBenchmark gEnv gErrorIgnoreLevel gErrorAbortLevel gRandom gStyle
   syn keyword	cSpecial        gRootDir gProgName gProgPath gSystem gVirtualPS gDragManager gGuiBuilder gCurrentRegion
   syn keyword	cSpecial        gClient gMinuit gHtml
endif
