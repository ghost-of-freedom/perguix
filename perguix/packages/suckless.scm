(define-module (perguix packages suckless)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)

  #:use-module (guix build-system gnu)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:))

(define-public perguix-st
  (package
    (name "perguix-st")
    (version "1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ghost-of-freedom/st")
             (commit "46de2f8fefcb2419ee012851db8ea165aaea5608")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1bmslm3hxwjmkm9apazp2kglwr60lniwbr8cqbz13b8xcq8cia18"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f                      ; no tests
               #:make-flags
               (list (string-append "CC=" ,(cc-for-target))
                     (string-append "TERMINFO="
                                    (assoc-ref %outputs "out")
                                    "/share/terminfo")
                     (string-append "PREFIX=" %output))
               #:phases
               (modify-phases %standard-phases
                              (delete 'configure))))
   (inputs
    (list libx11 libxft fontconfig freetype))
   (native-inputs
    (list ncurses pkg-config))
    (home-page "https://github.com/ghost-of-freedom/st")
    (synopsis "Fork of st with custom config and few patches")
    (description
     "@command{st} with custom config and following patches:
@itemize
@item @uref{https://st.suckless.org/patches/solarized/, solarized-light}
@item @uref{https://st.suckless.org/patches/boxdraw/, boxdraw}
@item @uref{https://st.suckless.org/patches/bold-is-not-bright/, bold-is-not-bright}
@end itemize")
    (license license:expat)))

(define-public perguix-dmenu
  (package
    (name "perguix-dmenu")
    (version "1.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/ghost-of-freedom/dmenu")
             (commit "0diwy6vg4jyjh9v94f77fz12ws0id4pvslk7k191x82y1nwwg0gk")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0diwy6vg4jyjh9v94f77fz12ws0id4pvslk7k191x82y1nwwg0gk"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f                      ; no tests
       #:make-flags
       (list (string-append "CC=" ,(cc-for-target))
             (string-append "PREFIX=" %output)
             (string-append "FREETYPEINC="
                            (assoc-ref %build-inputs "freetype")
                            "/include/freetype2"))
       #:phases
       (modify-phases %standard-phases (delete 'configure))))
    (inputs
     (list freetype libxft libx11 libxinerama))
    (home-page "https://github.com/ghost-of-freedom/dmenu")
    (synopsis "Fork of dmenu with custom config and few patches")
    (description
     "@command{dmenu} with custom config and following patches:
@itemize
@item @uref{https://tools.suckless.org/dmenu/patches/solarized/, solarized-light}
@item @uref{https://tools.suckless.org/dmenu/patches/case-insensitive/, case-insensitive}
@item @uref{https://tools.suckless.org/dmenu/patches/center/, center}
@item @uref{https://tools.suckless.org/dmenu/patches/border/, border}
@item @uref{https://tools.suckless.org/dmenu/patches/mouse-support/, mouse-support}
@item @uref{https://tools.suckless.org/dmenu/patches/separator/, separator}
@end itemize")
    (license license:expat)))
