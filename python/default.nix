{pkgs, ...}: {
  home.packages = [
    pkgs.pyright
    (pkgs.python312.withPackages (ppkgs: [
      ppkgs.numpy
      ppkgs.matplotlib
      ppkgs.pandas
      ppkgs.keras
      ppkgs.scikit-learn
      ppkgs.torch
      ppkgs.streamlit
      ppkgs.nltk
      ppkgs.flask
      ppkgs.torchvision
      ppkgs.tensorflow
      ppkgs.autopep8
    ]))
  ];
}

