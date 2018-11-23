;;@============================= LIBRARIES

(defconst OPENGL " -IGL -IGLUT -lglut -lGLEW -lGL " )

(defconst HANDMADE_COMPILER_FLAGS20  " -MT -nologo -Gm- -GR- -EHa- -Zo -O2 -Oi  -W4 -wd4201 -wd4100 -wd4189 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 -Fmwin32_handmade.map ")
(defconst HANDMADE_LINKER_FLAGS20 " -opt:ref user32.lib gdi32.lib winmm.lib ")


(defconst HANDMADE_COMPILER_FLAGS30  "      -MTd -nologo -fp:fast -Gm- -GR- -EHa- -Od -Oi  -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 ")
;; Maximize Speed
(defconst HANDMADE_COMPILER_FLAGS119  " -O2 -MTd -nologo -fp:fast -fp:except- -Gm- -GR- -EHa- -Zo -Oi  -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 ")
;; No optimizations
(defconst HANDMADE_COMPILER_FLAGS143 " -Od  -MTd -nologo -fp:fast -fp:except- -Gm- -GR- -EHa- -Zo -Oi  -W4 -wd4201 -wd4100 -wd4189 -wd4505 -wd4127 -DHANDMADE_INTERNAL=1 -DHANDMADE_SLOW=1 -DHANDMADE_WIN32=1 -FC -Z7 ")

(defconst HANDMADE_LINKER_FLAGS143 " -incremental:no -opt:ref user32.lib gdi32.lib winmm.lib ")

(defun compile-handmade20(filename)
  (concat "cl "  HANDMADE_COMPILER_FLAGS20 filename " /link -subsystem:windows,5.1 "  HANDMADE_LINKER_FLAGS20 ))

(defun compile-handmade30 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS30 " ../handmade.cpp -Fmhandmade.map /LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender "  
          " && cl " HANDMADE_COMPILER_FLAGS30 " ../win32_handmade.cpp  -Fmhandmade.map  /link  "   HANDMADE_LINKER_FLAGS143 ))


(defun compile-handmade119 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS119 " ../handmade.cpp -Fmhandmade.map /LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender "  
          " && cl " HANDMADE_COMPILER_FLAGS119 " ../win32_handmade.cpp  -Fmhandmade.map  /link  "   HANDMADE_LINKER_FLAGS143 ))


(defun compile-handmade143 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS143 " -I../iaca-win64/ ../handmade.cpp -Fmhandmade.map -LD /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender "  
          " && cl " HANDMADE_COMPILER_FLAGS143 " ../win32_handmade.cpp  -Fmwin32_handmade.map  /link  "   HANDMADE_LINKER_FLAGS143 ))

(defun compile-handmade144 (filename)
  (concat
   "del *.pdb > NUL 2> NUL && "
   "cl " HANDMADE_COMPILER_FLAGS143 " -O2 -I../iaca-win64/ -c ../handmade_optimized.cpp -Fohandmade_optimized.obj  -LD "  
   " && cl " HANDMADE_COMPILER_FLAGS143 " -I../iaca-win64/   ../win32_handmade.cpp handmade_optimized.obj -Fmhandmade.map -LD  /link -incremental:no -opt:ref -PDB:handmade_%random%.pdb -EXPORT:GameGetSoundSamples -EXPORT:GameUpdateAndRender "
   " && del lock.tmp  "
   " && cl " HANDMADE_COMPILER_FLAGS143 " ../win32_handmade.cpp  -Fmwin32_handmade.map  /link  "   HANDMADE_LINKER_FLAGS143 ))


(if (eq system-type 'windows-nt)
    (progn
      (defconst SDL2 " -lSDL2_image -lpng -lz")
      (defconst HANDMADE "")
      (defconst SDL " -lmingw32 -lSDLmain -lSDL -lSDL_image -lSDL_ttf -lSDL_mixer ")
      (defconst ALLEGRO " -lallegro-4.4.2-mt"))
  (progn
    (defconst SDL2 " `sdl2-config --cflags --libs` -lSDL2_image -lpng -lz")
    (defconst SDL " `sdl-config --cflags --libs` -lSDL_image -lSDL_ttf -lSDL_mixer ")
    (defconst ALLEGRO  " `allegro-config --libs`   -lm  -lpng -lz"))) ;;  -lm  -lpng -lz -laldmd -ldumbd ldumb"


(defconst ALLEGRO5" `allegro-config --libs` `pkg-config --cflags --libs allegro-5.0  ` -lldpng  -lpng -lz ")
(defconst SRGP " -L/usr/X11R6/lib -lsrgp -lX11] ")
(defconst WINLIBS " user32.lib gdi32.lib winmm.lib ")

(defconst terminal-run  "gnome-terminal -x ")

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
	(unless current-prefix-arg
        (delete-windows-on (get-buffer "*compilation*")))
        (kill-buffer "*compilation*"))
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
(defun libraries-string (l)
  (let ((libraries "" ))
    (cond
     ((member 'sdl l) (setq libraries (concat libraries  SDL)))
     ((member 'sdl2 l) (setq libraries (concat libraries  SDL2)))
     ((member 'opengl l) (setq libraries (concat libraries  OPENGL)))
     ((member 'windows l) (setq libraries (concat libraries  WINLIBS)))
     ((member 'allegro l) (setq libraries (concat libraries  ALLEGRO))))
    libraries))

(defun create-compile-string(buffername options)
  (let  ((compile-string "")
	 (c (member 'c options))
	 (cpp (member 'cpp options))
	 (cweb (member 'cweb options))
	 (debug (member 'debug options))
	 (make (member 'make options))
	 (handmade  (member 'handmade options))
	 (multiple (member 'multiple options))
	 (profile (member 'profile options))
	 (run (member 'run options))
	 (vs (member 'windows  options))
	 )
    (cond
     (make
      (setq compile-string "make"))
     (handmade
      (setq compile-string (compile-handmade144 (concat " ../win32_handmade.cpp" ))))

     
     ((or c cpp)
      (let  ((file-extension (if c ".c " ".cpp "))
	     (cweb-extension (if c ".w" ".w_cpp "))
	     (command-string (if c  (if vs "cl -Zi " "gcc -std=c99 ")
			       (if vs "cl -Zi " " g++ "))))
	(progn (when cweb  
		 (setq compile-string (concat "ctangle ../"
					      buffername
					      cweb-extension
					      " && ")))
	       (setq compile-string (concat compile-string
					    command-string))
	       (when profile
		 (setq compile-string (concat
				       compile-string
				       "-pg ")))
	       (when debug
		 (setq compile-string (concat
				       compile-string
				       "-g ")))
	       (if multiple
		   (setq compile-string (concat
					 compile-string
					 "  ../*"
					 file-extension
					 " -o main"))
		 (setq compile-string (concat compile-string
					      "../"
					      buffername
					      file-extension
					      " -o "
					      buffername )))
	       (setq compile-string (concat
				     compile-string
				     (libraries-string options)
				     " "))
	       (when run
		 (setq compile-string (concat compile-string
					      " && " (if vs (concat default-directory "build/")
						       (concat  default-directory "build/"))
					      buffername)))))))
    compile-string))

;;(create-compile-string "buffername" '(c ))


;;@============================= SET COMPILATION COMMAND
(defun set-compile-command(arg config)
  "Sets compile-command by selecting among a list of options."
  (interactive "P\nsCompile command: c, cpp, cweb, multiple, debug,profile, windows, libraries (sdl sdl2 allegro opengl): " ) 
    (set (make-local-variable 'compile-command)
         (create-compile-string (buffer-name-no-extension) (mapcar (lambda (a) (intern a)) (split-string config))))) 

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
            (kill-buffer "*Async Shell Command*") )))))


;;@============================= HOOKS
(add-hook 'c-mode-hook
          (lambda ()
             (set (make-local-variable 'compile-command)
	     (create-compile-string
	      (buffer-name-no-extension)
	      (mapcar (lambda (a) (intern a)) (split-string
					       (concat "c " SDL)))))))
(add-hook 'c++-mode-hook
          (lambda ()
             (set (make-local-variable 'compile-command)
	     (create-compile-string
	      (buffer-name-no-extension)
	      (mapcar (lambda (a) (intern a)) (split-string
					       (concat "cpp windows
          run " )))))))
