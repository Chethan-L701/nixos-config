{pkgs, ...}: {
  home.packages = [
    pkgs.pyright
    (pkgs.python312.withPackages (ppkgs: [
      ppkgs.numpy
      ppkgs.matplotlib
      ppkgs.pandas
      ppkgs.autopep8
    ]))
  ];
}

