(define-module (perguix packages wm)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages base)
  #:use-module (gnu packages autotools)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (guix licenses)
  #:use-module (guix packages))

(define-public perguix-i3ipc-glib
  (package
   (name "perguix-i3ipc-glib")
   (version "1.0.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/altdesktop/i3ipc-glib")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1gr7cg9qvdpjbjjl6g6sn43hk21xa9wnmlygfqiv9sazyw4ynirl"))))
   (build-system gnu-build-system)
   (inputs (list libxcb xcb-proto glib gobject-introspection json-glib gtk-doc))
   (native-inputs
    (list libxcb
          xcb-proto
          `(,glib "bin") ; for glib-mkenums
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
