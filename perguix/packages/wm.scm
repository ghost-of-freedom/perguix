(define-module (perguix packages wm)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages base)
  #:use-module (gnu packages autotools)
  #:use-module (guix build-system gnu)

  ;#:use-module (guix build utils)
  
  #:use-module (guix git-download)
  #:use-module (guix licenses)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix packages))

(define-public perguix-i3ipc-glib
  (package
   (name "perguix-i3ipc-glib")
   (version "1.0.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/i3ipc-glib")
           (commit "ef6d03007f1f1d14d1ab171dc63e02f30f0fa5b3")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1gr7cg9qvdpjbjjl6g6sn43hk21xa9wnmlygfqiv9sazyw4ynirl"))))
   (build-system gnu-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
       (delete 'configure) ; called by autogen
       (add-after 'unpack 'autogen
        (lambda* (#:key outputs #:allow-other-keys)
          (let ((out (assoc-ref outputs "out")))
            (invoke "sh" "autogen.sh" (string-append "--prefix=" out)))
          #t)))))
   (inputs
    (list libxcb
          xcb-proto
          `(,glib "bin")
          `(,glib "static")
          `(,glib "out")
          gobject-introspection
          json-glib
          gtk-doc))
   (native-inputs
    (list libxcb
          xcb-proto
          `(,glib "bin") ; for glib-mkenums
          `(,glib "static")
          `(,glib "out")
          gobject-introspection
          json-glib
          gtk-doc
          which
          autoconf
          automake ; for aclocal
          pkg-config
          libtool))
   (home-page "https://github.com/altdesktop/i3ipc-glib")
   (synopsis "A C interface library to i3wm")
   (description "i3ipc-GLib is a C library for controlling the window manager. This project is intended to be useful in applications such as status line generators, pagers, notification daemons, scripting wrappers, external controllers, dock windows, compositors, config templaters, and for debugging or testing the window manager itself.")
   (license gpl3)))

(define-public perguix-i3-easyfocus
  (package
   (name "perguix-i3-easyfocus")
   (version "0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/ghost-of-freedom/i3-easyfocus")
           (commit "e3f998c67b6e4c4b6278ed68bb9a175dd760081d")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0m9icf2bn7lnkad5smpizai2wryxvbhdsc1vviw1av2x1wb9cmm8"))))
   (build-system gnu-build-system)
   (arguments
    '(#:phases (modify-phases %standard-phases
                (delete 'configure))))
   (inputs (list perguix-i3ipc-glib xcb-util-keysyms libxcb libx11))
   (native-inputs (list perguix-i3ipc-glib xcb-util-keysyms libxcb pkg-config libx11))
   (home-page "https://github.com/cornerman/i3-easyfocus")
   (synopsis "Focus and select windows in i3 ")
   (description "Draws a small label ('a'-'z') on top of each visible container, which can be selected by pressing the corresponding key on the keyboard (cancel with ESC). By default, only windows on the current workspace are labelled.")
   (license gpl3)))
