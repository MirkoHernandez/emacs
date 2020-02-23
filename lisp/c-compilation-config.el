;;@============================= HANDMADE COMPILATION

;; Optimization switches /O2 /Oi /fp:fast

;; COMPILER
;; /Zi	Generates complete debugging information.
;; /EH	Specifies the model of exception handling.
;; /fp	Specify floating-point behavior.
;; /FC	Display full path of source code files passed to cl.exe in diagnostic text.
;; /Fm	Creates a map file.
;; /Gm	Deprecated. Enables minimal rebuild.
;; /GR	Enables run-time type information (RTTI).
;; /MT	Creates a multithreaded executable file using LIBCMT.lib.
;; /Od	Disables optimization.
;; /Oi	Generates intrinsic functions.
;; /W0,/W1,/W2,/W3,/W4	Sets which warning level to output.
;; /wd	Disables the specified warning.
;; /WX	Treats all warnings as errors.
;; /Z7	Generates C 7.0-compatible debugging information.
;; /Zo  Generate enhanced debugging information for optimized code in non-debug builds.
;; /nologo	Suppresses display of sign-on banner.

;; LINKER
;; /EXPORT	  Exports a function.
;; /INCREMENTAL   Controls incremental linking.
;; /OPT		  Controls LINK optimizations.
;; /OPT:REF       eliminates functions and data that are never referenced.
;; /OPT:NOREF     keeps functions and data that are never referenced.
;; /PDB		  Creates a program database (PDB) file.
;; /SUBSYSTEM	  Tells the operating system how to run the .exe file.

;; LIBS
;;  user32.lib gdi32.lib winmm.lib;
 
(defun compile-handmade(day run)
  (let (
	(libs15  " user32.lib gdi32.lib ")
	(libs230  " user32.lib gdi32.lib winmm.lib ")
	(flags300 " -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 ")
	; Linker Options
	(linker20 " -opt:ref ")
	(linker143 " -incremental:no -opt:ref ")
	(linker-handmade21  " -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender ")
	(linker-handmade23  " -incremental:no -opt:ref -PDB:handmade_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%%time:~6,2%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender ")
	(linker-handmade25  " -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender ")
	;; Compiler Options, -WX is omitted.
	(compiler15 " -FC -Zi ")
	(compiler20 " -MT -nologo -Gm- -GR- -EHa- -Zo -O2 -Oi -W4 -wd4201 -wd4100 -wd4189 -FC -Z7 -Fmwin32_handmade.map ")
	(compiler23 " -MT -nologo -Gm- -GR- -EHa- -Od -Oi -W4 -wd4201 -wd4100 -wd4189 -FC -Z7 ")
	(compiler26 " -MTd -nologo -Gm- -GR- -EHa- -Od -Oi -W4 -wd4201 -wd4100 -wd4189 -FC -Z7 ")
	(compiler33 " -MTd -nologo -Gm- -GR- -EHa- -Od -Oi -W4 -wd4201 -wd4100 -wd4189 -wd4505 -FC -Z7 ")
	(compiler89 " -MTd -nologo -fp:fast -Gm- -GR- -EHa- -Od -Oi -W4 -wd4201 -wd4100 -wd4189 -wd4505 -FC -Zi "))
  (cond
   ((equal day "10")
    (concat "cl "  compiler15  " ../win32_handmade.cpp " libs15
	    (when run " && win32_handmade.exe")))
   ((equal day "15") ;; 11-15
    (concat "cl "   compiler15  flags300  " ../win32_handmade.cpp " libs15
	    (when run " && win32_handmade.exe")))
   ((equal day "20")
    (concat "cl " compiler20 flags300  " ../win32_handmade.cpp "
	    " /link " linker20  libs230
	    (when run " && win32_handmade.exe")))
   ((equal day "21")
    (concat "cl " compiler23  flags300  " ../handmade.cpp  -Fmhandmade.map"
	    " -LD /link " linker-handmade21 " && "
	    "cl " compiler23 flags300 "../win32_handmade.cpp -Fmwin32_handmade.map "
	    " /link " linker143  libs230
	    (when run " && win32_handmade.exe")))
   ((equal day "23")
    (concat "cl " compiler23 flags300  " ../handmade.cpp  -Fmhandmade.map"
	    " -LD /link "  linker-handmade23  " && "
	    "cl "  compiler23 flags300 "../win32_handmade.cpp -Fmwin32_handmade.map "
	    " /link "  linker143 libs230
	    (when run " && win32_handmade.exe")))
   ((equal day "26")
    (concat "cl " compiler26 flags300  " ../handmade.cpp  -Fmhandmade.map"
	    " -LD /link "  linker-handmade25  " && "
	    "cl "  compiler26 flags300 "../win32_handmade.cpp -Fmwin32_handmade.map "
	    " /link "  linker143 libs230
	    (when run " && win32_handmade.exe")))

   ((equal day "33")
    (concat "cl " compiler89 flags300  " ../handmade.cpp  -Fmhandmade.map"
	    " -LD /link "  linker-handmade25  " && "
	    "cl "  compiler89 flags300 "../win32_handmade.cpp -Fmwin32_handmade.map "
	    " /link "  linker143 libs230
	    (when run " && win32_handmade.exe")))
    ((equal day "38")
    (concat "cl " compiler45 flags300  " ../handmade.cpp  -Fmhandmade.map"
	    " -LD /link "  linker-handmade25  " && "
	    "cl "  compiler45 flags300 "../win32_handmade.cpp -Fmwin32_handmade.map "
	    " /link "  linker143 libs230
	    (when run " && win32_handmade.exe")))
    ((equal day "89")
     (concat "echo WAITING FOR PDB > lock.tmp && "
      "cl " compiler89 flags300  " ../handmade.cpp  -Fmhandmade.map"
      " -LD /link "  linker-handmade25  " && "
      "del lock.tmp && "
      "cl "  compiler89 flags300 "../win32_handmade.cpp -Fmwin32_handmade.map "
      " /link "  linker143 libs230
      (when run " && win32_handmade.exe")))
    ((> (string-to-number day) 200 )
     nil)
    (t
     (compile-handmade (number-to-string 
			(1+ (string-to-number day)))
		       run)))))

;;@============================= LIBRARIES
(if (eq system-type 'windows-nt)
    (setq libraries-table
      #s(hash-table size 20 test equal
		    data (
			  "user"   "user32.lib"
			  "gdi"  "gdi32.lib"
			  "winm" "winm.lib"
			  "sdl2" "-lSDL2_image -lpng -lz -lm"
			  "sdl"  "-lmingw32 -lSDLmain -lSDL -lSDL_image -lSDL_ttf -lSDL_mixer"
			  "winlibs" "user32.lib gdi32.lib winmm.lib"
			  "opengl"   "-IGL -IGLUT -lglut -lGLEW -lGL"
			  "allegro"  "-lallegro-4.4.2-mt")))
    (setq libraries-table
      #s(hash-table size 20 test equal
		    data (
			   "sdl2"     "`sdl2-config --cflags --libs` -lSDL2_image -lpng -lz"
			   "sdl"      "`sdl-config --cflags --libs` -lSDL_image -lSDL_ttf -lSDL_mixer"
			   "dumb"     "-laldmd -ldumbd -ldumb"
			   "srgp"     "-L/usr/X11R6/lib -lsrgp -lX11"
			   "opengl"   "-IGL -IGLUT -lglut -lGLEW -lGL"
			   "allegro5" "`allegro-config --libs` `pkg-config --cflags --libs allegro-5.0  ` -lldpng  -lpng -lz"
			   "allegro"  "`allegro-config --libs` -lm  -lpng -lz" ))))

(defun libraries-string (l)
  (let ((libraries-string " ")
	(libraries (split-string l)))
    (mapc (lambda (x)
	    (when (gethash x libraries-table)
	       (setq libraries-string (concat libraries-string (gethash x libraries-table) " "))))
	     libraries)
    libraries-string))

;;@============================= HELPERS
(defun buffer-name-no-extension ()
  "Return the name of the buffer without the extension."
  (file-name-sans-extension (file-name-nondirectory (buffer-name))))

;;@============================= COMPILATION COMMANDS
(defun compile-or-delete-window (arg)
  "Delete the *compilation* window or call the compile command if the window does not exist.
  Every program is compiled and executed inside a build folder."
  (interactive "p")
  (if (get-buffer "*compilation*")
      (progn
	  (delete-windows-on (get-buffer "*compilation*"))
	  (kill-buffer "*compilation*"))
      ;; (save-buffer)
      (call-process-shell-command (concat "mkdir " (when (string-equal
							  system-type
							  "gnu/linux")
						     "-p")
					  " build" ) nil 0)
      (let ((default-directory (concat default-directory "build")))
	(compile compile-command))))

;;@============================= GENERATING COMPILE STRINGS
(setq c-compile-table
      #s(hash-table
	 size 20
	 test equal
	 data (
	       "windows" "cl -Zi "
	       "cweb" "something"
	       "cweb cpp"  (lamda (buffername) ) (concat "ctangle ../" buffername ".w_cpp && " )
	       "cweb c"  (lamda (buffername) ) (concat "ctangle ../" buffername ".w && " ))))

(defun create-compile-string(buffername options)
  (defun compare-options (rgx)
    (string-match-p rgx options))
  (let  ((compile-string "")
	 (make (compare-options "make"))
	 (run  (compare-options "\\<run\\>"))
	 (cweb (compare-options "\\<cweb\\>"))
	 (c (compare-options "\\<c\\>"))
	 (cpp (compare-options "\\<cpp\\>"))
	 (windows (compare-options "\\<windows\\>"))
	 (profile (compare-options "\\<profile\\>"))
	 (debug (compare-options "\\<debug\\>"))
	 (resources (compare-options "\\<resources\\>"))
	 (multiple (compare-options "\\<multiple\\>")))
      (when make
	(setq compile-string "make"))
      (when (string-match "handmade\\([0-9]+\\)" options)
	(setq compile-string
	      (compile-handmade (match-string 1 options) run)))
      (when cweb
	(progn
	  (setq compile-string (concat "ctangle ../"  buffername))
	  (when c
	    (setq compile-string (concat compile-string ".w")))
	  (when cpp
	    (setq compile-string (concat compile-string ".w_cpp")))))
      (cond (windows
	     (setq compile-string (concat compile-string "cl -Zi ")))
	    (c
	     (setq compile-string (concat compile-string "gcc -std=c99 ")))
	    (cpp
	     (setq compile-string (concat compile-string "g++  "))))
      (when profile
	(setq compile-string (concat compile-string "-pg ")))
      (when debug
	(setq compile-string (concat compile-string "-g ")))
      (when c
	(if multiple
	    (setq compile-string (concat  compile-string  " ../*"    ".c -o main"))
	  (setq compile-string (concat compile-string   " ../" buffername ".c  -o " buffername ))))
      (when cpp
	(if multiple
	    (setq compile-string (concat  compile-string  " ../*"    ".cpp " (if windows "/Fe" "-o ") "main "))
	  (setq compile-string (concat compile-string   " ../" buffername ".cpp " (if  windows "/Fe" "-o ")  buffername ))))
      (when (or c cpp)
	(setq compile-string (concat  compile-string   (libraries-string options) " ")))
      (when run
	(if windows
	    (setq compile-string (concat compile-string
					 (when resources "/link resources.res ")
					 " &&  cd .. && "  "build\\" buffername))
	  (setq compile-string (concat compile-string    " &&  cd .. && "  "build/" buffername))))
      compile-string))

;;@============================= SET COMPILATION COMMAND
(defun set-compile-command(arg config)
  "Sets compile-command by selecting among a list of options."
  (interactive "P\nsOptions:  make| cweb | c cpp cweb |  multiple | debug profile | [sdl sdl2 allegro dumb allegro5 opengl]): " )
  (set (make-local-variable 'compile-command)
       (create-compile-string (buffer-name-no-extension)  config)))

;;@=============================  CHICKEN
(defun chicken-compile ()
  (interactive)
  (unless (or (file-exists-p "makefile")
	      (file-exists-p "Makefile"))
    (set (make-local-variable 'compile-command)
	 (let ((file  (file-name-base)))
	   (concat
	    "csc " file ".scm ")))))

(defun cweb-terminal ()
  (interactive)
  (unless (or (file-exists-p "makefile")
	      (file-exists-p "Makefile"))
    (set (make-local-variable 'compile-command)
	 (concat
	  "ctangle " (file-name-nondirectory buffer-file-name) " && "
	  "gcc -g -std=c99  "   (file-name-base) ".c "
	  "  -o "(file-name-base) ".out &&"
	  "gnome-terminal -x ./" (file-name-base) ".out " ))))

;;@============================= WINDOWS 
(defun compile-resources ()
  (interactive)
  (shell-command (concat "rc -fo build\\" (file-name-base)  ".res "  (file-name-nondirectory buffer-file-name))))

(defun remedybg (arg executable)
  (interactive "P\nsExecutable: ")
  (async-shell-command-no-window  (concat "remedybg.exe " executable )))

;;@============================= CWEAVE
ivy-previous-history-element
(defun pdftex ()
  (interactive)
  (async-shell-command (concat "pdftex  " (file-name-base) ".tex && "  "evince " (file-name-base) ".pdf & " )))

(setf delete-cweave-files (concat "rm *.tex && "
				  "rm *.log && "
				  "rm *.scn && "
				  "rm *.idx && "
				  "rm *.toc && " ))

(defun cweaved () ;; debug
  "Run cweave, pdftex and evince in a shell command with the name of the buffer as a filename argument."
  (interactive)
  (let ((file  (file-name-base)))
    (shell-command (concat "cweave  -bhp -e "  (file-name-nondirectory buffer-file-name)         "&& "
			   "pdftex  -file-line-error " file ".tex && "
			   (delete-cweave-files file)
			   "evince " file ".pdf & " ))))

(defun cweaved-noindex () ;; debug
  "Run cweave, pdftex and evince in a shell command, no index in the pdf."
  (interactive)
  (let ((file  (file-name-base)))
    (shell-command (concat "cweave -x -bhp -e "  (file-name-nondirectory buffer-file-name)       " && "
			   "pdftex  -file-line-error " file ".tex && "
			   (delete-cweave-files file)
			   "evince " file ".pdf & " ))))

(defun clean-cweave () ;; debug
  ""
  (interactive)
  (let ((file  (file-name-base)))
    (shell-command
     (delete-cweave-files file))))

(defun pdf-to-external-drive ()
  "Shell command.  Copy pdf file to the directory where the external drive is mounted."
  (interactive)
  (let ((file (file-name-base)))
    (shell-command (concat "cp  " (file-name-base) ".pdf  "
				 (getenv "READER_DRIVE") " &"  ))))

(defun cweave ()
  "Shell command.  Run cweave and kill the shell window afterwards."
  (interactive)
  (let ((file  (file-name-base)))
    (async-shell-command (concat "cweave "  (file-name-nondirectory buffer-file-name) "&& "
				 "pdftex  " file ".tex && "
				 (delete-cweave-files file)
				 "evince " file ".pdf & " ))
    (progn
      (if (get-buffer "*Async Shell Command*") ; If old compile window exists
	  (progn
	    (delete-windows-on (get-buffer "*Async Shell Command*")) ; Delete the compilation window
	    (kill-buffer "*Async Shell Command*"))))))


;;@============================= GUD
(setq  gdb-many-windows t)
(setq  gdb-show-main nil)

(defadvice gdb-setup-windows (around setup-more-gdb-windows activate)
  ad-do-it
  (other-window 1)
  (gdb-set-window-buffer
    (gdb-get-buffer-create 'gdb-disassembly-position)))

(defun gdb-setup-windows ()
  "Layout the window pattern for option `gdb-many-windows'."
  (gdb-get-buffer-create 'gdb-locals-buffer)
  (gdb-get-buffer-create 'gdb-stack-buffer)
  (gdb-get-buffer-create 'gdb-breakpoints-buffer)
  (set-window-dedicated-p (selected-window) nil)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (let ((win0 (selected-window))
	(win1 (split-window nil ( / ( * (window-height) 3) 4)))
	(win2 (split-window nil ( / (window-height) 3)))
	(win3 (split-window-right)))
    (gdb-set-window-buffer (gdb-locals-buffer-name) nil win3)
    (select-window win2)
    (set-window-buffer
     win2
     (if gud-last-last-frame
	 (gud-find-file (car gud-last-last-frame))
       (if gdb-main-file
	   (gud-find-file gdb-main-file)
	 ;; Put buffer list in window if we
	 ;; can't find a source file.
	 (list-buffers-noselect))))
    (setq gdb-source-window (selected-window))
    (let ((win4 (split-window-right)))
      (gdb-set-window-buffer
       (gdb-get-buffer-create 'gdb-inferior-io) nil win4))
    (select-window win1)
    (gdb-set-window-buffer (gdb-stack-buffer-name))
    (let ((win5 (split-window-right)))
      (gdb-set-window-buffer (if gdb-show-threads-by-default
				 (gdb-threads-buffer-name)
			       (gdb-breakpoints-buffer-name))
			     nil win5))
    (select-window win0)))



;;@============================= HOOKS
(add-hook 'c-mode-hook
	  (lambda ()
	     (set (make-local-variable 'compile-command)
	     (create-compile-string
	      (buffer-name-no-extension)
	      "c sdl run " ))))

(add-hook 'c++-mode-hook
	  (lambda ()
	     (set (make-local-variable 'compile-command)
	     (create-compile-string
	      (buffer-name-no-extension)
	      "cpp windows run user gdi" ))))
