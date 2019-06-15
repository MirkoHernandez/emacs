;;@============================= LIBRARIES


(defconst HANDMADE_COMPILER_FLAGS20  " -MT -nologo -Gm- -GR- -EHa- -Zo -O2 -Oi  -W4 -wd4201 -wd4100 -wd4189 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 -Fmwin32_handmade.map ")
(defconst HANDMADE_LINKER_FLAGS20 " -opt:ref user32.lib gdi32.lib winmm.lib ")

(defconst HANDMADE_COMPILER_FLAGS30  " -MTd -nologo -fp:fast -Gm- -GR- -EHa- -Od -Oi  -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 ")
;; Maximize Speed
(defconst HANDMADE_COMPILER_FLAGS119  " -O2 -MTd -nologo -fp:fast -fp:except- -Gm- -GR- -EHa- -Zo -Oi  -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 ")
;; No optimizations
(defconst HANDMADE_COMPILER_FLAGS143 " -Od  -MTd -nologo -fp:fast -fp:except- -Gm- -GR- -EHa- -Zo -Oi  -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 ")

(defconst HANDMADE_LINKER_FLAGS143 " -incremental:no -opt:ref user32.lib gdi32.lib winmm.lib ")

(setq handmade-flags
      #s(hash-table size 20 test equal
		    data (
			  ;; Linker Flags
			  "linker20" " -opt:ref user32.lib gdi32.lib winmm.lib "
			  "linker143" " -incremental:no -opt:ref user32.lib gdi32.lib winmm.lib "
			  ;; Compiler Flags
			  "compiler20" " -MT -nologo -Gm- -GR- -EHa- -Zo -O2 -Oi  -W4 -wd4201 -wd4100 -wd4189 
                                         -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 -Fmwin32_handmade.map "
			  "compiler30" " -MTd -nologo -fp:fast -Gm- -GR- -EHa- -Od -Oi  -W4 -wd4201 -wd4100 -wd4189 
                                         -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 "
			  ;; Maximize speed
			  "compiler119" " -O2 -MTd -nologo -fp:fast -fp:except- -Gm- -GR- -EHa- -Zo -Oi  -W4 -wd4201 
                                          -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 
                                          -DHANDMADE_WIN32=1 -FC -Z7 "
			  ;; No optimizations
			  "compiler143"  "-Od  -MTd -nologo -fp:fast -fp:except- -Gm- -GR- -EHa- -Zo -Oi  -W4 -wd4201 
                                          -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 
                                          -DHANDMADE_WIN32=1 -FC -Z7 "
			   "dll144"  " /LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender"
			   )))

(setq handmade-table
      #s(hash-table size 20 test equal
		    data (
			  "handmade20" (lambda (filename) (concat "cl "  (gethash "compiler20" handmade-flags) filename
					       " /link -subsystem:windows,5.1 "  (gethash "compiler20" handmade-flags))))
		    ))

(defun compile-handmade20(filename)
  (concat "cl "  HANDMADE_COMPILER_FLAGS20 "../win32_handmade.cpp
 /link -subsystem:windows,5.1 "  HANDMADE_LINKER_FLAGS20 ))


(defun compile-handmade30 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS30
   " ../handmade.cpp -Fmhandmade.map /LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender  && "
   "cl "  HANDMADE_COMPILER_FLAGS30
   " ../win32_handmade.cpp  -Fmhandmade.map  /link  "
   HANDMADE_LINKER_FLAGS143 ))

(defun compile-handmade119 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS119
   " ../handmade.cpp -Fmhandmade.map /LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb 
     -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender  && "
   "cl " HANDMADE_COMPILER_FLAGS119 " ../win32_handmade.cpp  -Fmhandmade.map  /link  "
   HANDMADE_LINKER_FLAGS143 ))

(defun compile-handmade143 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS143 " -I../iaca-win64/ ../handmade.cpp -Fmhandmade.map -LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender "  
          " && cl " HANDMADE_COMPILER_FLAGS143 " ../win32_handmade.cpp  -Fmwin32_handmade.map  /link  "   HANDMADE_LINKER_FLAGS143 ))

(defun compile-handmade144 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "   "cl " HANDMADE_COMPILER_FLAGS143 " -O2 -I../iaca-win64/ -c ../handmade_optimized.cpp -Fohandmade_optimized.obj  -LD "  
   " && cl " HANDMADE_COMPILER_FLAGS143 " -I../iaca-win64/   ../win32_handmade.cpp handmade_optimized.obj -Fmhandmade.map -LD  /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender "
   " && del lock.tmp  "
   " && cl " HANDMADE_COMPILER_FLAGS143 " ../win32_handmade.cpp  -Fmwin32_handmade.map  /link  "   HANDMADE_LINKER_FLAGS143 ))


(if (eq system-type 'windows-nt)
    (setq libraries-table
      #s(hash-table size 20 test equal
		    data (
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
	       (setq libraries-string (concat libraries-string (gethash x libraries-table) " ")))
	    ) libraries)
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
      ;; (progn 
      ;; (unless current-prefix-arg
      (delete-windows-on (get-buffer "*compilation*"))
    ;; (kill-buffer "*compilation*"))
    (progn
      (save-buffer)
      (call-process-shell-command (concat "mkdir " (when (string-equal
							  system-type
							  "gnu/linux")
						     "-p")
					  " build" ) nil 0)
      (let ((default-directory (concat default-directory "build")))
        (compile compile-command)))))

;;@============================= GENERATING COMPILE STRINGS
(setq c-compile-table
      #s(hash-table
	 size 20
	 test equal
	 data (
	       "vs" "cl -Zi "
	        "cweb" "something"
	       "cweb cpp"  (lamda (buffername) ) (concat "ctangle ../" buffername ".w_cpp && " )
	       "cweb c"  (lamda (buffername) ) (concat "ctangle ../" buffername ".w && " ))))

(defun create-compile-string(buffername options)
  (defun compare-options (rgx)
    (string-match-p rgx options))
  (let  ((compile-string ""))
    (progn
     (when (compare-options "make")
       (setq compile-string "make"))
     (when (string-match-p "handmade[0-9]+" options)
       (setq compile-string (compile-handmade144 (concat " ../win32_handmade.cpp" ))))
     (when (string-match-p "cweb" options)
       (progn
	 (setq compile-string (concat "ctangle ../"  buffername))
	 (when (string-match-p "\\<c\\>" options)
		(setq compile-string (concat compile-string ".w")))
	 (when (string-match-p "cpp" options)
	   (setq compile-string (concat compile-string ".w_cpp")))))
     (cond ((string-match-p "\\<vs\\>" options)
	    (setq compile-string (concat compile-string "cl -Zi")))
	   ((string-match-p "\\<c\\>" options)
	    (setq compile-string (concat compile-string "gcc -std=c99 ")))
	   ((string-match-p "cpp" options)
	    (setq compile-string (concat compile-string "g++  "))))
     (when (string-match-p "profile" options )
       (setq compile-string (concat compile-string "-pg ")))
     (when (string-match-p "debug" options )
       (setq compile-string (concat compile-string "-g ")))
     (when (string-match "\\<c\\>" options)
       (if (string-match "multiple" options)
	   (setq compile-string (concat  compile-string  " ../*"    ".c -o main"))
	 (setq compile-string (concat compile-string   " ../" buffername ".c  -o " buffername ))))
     (when (string-match "cpp" options)
       (if (string-match "multiple" options)
	   (setq compile-string (concat  compile-string  " ../*"    ".cpp -o main"))
	 (setq compile-string (concat compile-string   " ../" buffername ".cpp  -o " buffername ))))
     (when (or (string-match "\\<c\\>" options)
	       (string-match "cpp" options))
       (setq compile-string (concat  compile-string   (libraries-string options) " ")))
     (when (string-match "\\<run\\>" options)
       (setq compile-string (concat compile-string    " &&  cd .. &&  "  "build/" buffername)))
     compile-string)))
 

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


;;@============================= CWEAVE
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
	      "cpp vs run " ))))
