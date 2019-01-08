(global-set-key "\C-c3tT" '3t-frdcsa-launcher-restart)
(global-set-key "\C-c3tt" '3t-frdcsa-launcher)
(global-set-key "\C-c3tk" '3t-frdcsa-kill)
(global-set-key "\C-c3ods" '3t-frdcsa-open-allegro-documentation-startup)
(global-set-key "\C-c3oda" '3t-frdcsa-open-ap-documentation)
(global-set-key "\C-c3tP" '3t-frdcsa-plan)
(global-set-key "\C-c3tp" '3t-frdcsa-plan-restart)
(global-set-key "\C-c3tl" '3t-frdcsa-plan-restart-lad)
(global-set-key "\C-c3td" '3t-frdcsa-choose-domain-file)

(global-set-key "\C-c3spl" '3t-frdcsa-search-3t-planner-lisp-files)
(global-set-key "\C-c3spd" '3t-frdcsa-search-3t-planner-documentation)
(global-set-key "\C-c3sal" '3t-frdcsa-search-3t-allegro-lisp-files)
(global-set-key "\C-c3sad" '3t-frdcsa-search-3t-allegro-documentation)

(defvar 3t-frdcsa-acl81-documentation-dir "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/doc")
(defvar 3t-frdcsa-3t-buffer "*3t Planner*")
(defvar 3t-frdcsa-plans nil)

(setq 3t-frdcsa-loadables
 '("manufacturing" "time" "ap" "org" "physob" "foaf" "communication"
 "capability" "event" "CBRN;AGENT" "CBRN;Chem;ChemAgent"
 "CBRN;Chem;diphosgene" "CBRN;Chem;CBRNEChemical"
 "CBRN;RTS-AI;NorthKorea" "CBRN;RTS-AI;DIMEFIL"
 "CBRN;RTS-AI;nuclear_weapon" "CBRN;RTS-AI;threat-behaviors"
 "CBRN;RTS-AI;Iran" "CBRN;Equipment;CBRNEMatEquip" "CBRN;Bio;bio"
 "CBRN;Bio;BioAgent" "CBRN;Bio;Botulinum" "CBRN;Nuke;mining-milling"
 "CBRN;Nuke;enrichment" "CBRN;Nuke;nuclear" "commerce;commerce"
 "commerce;international-commerce" "nasa;phalcon-eva"
 "nasa;situations2" "nasa;problems2" "nasa;base" "nasa;ISS-base"
 "nasa;nasa2i" "nasa;nasa2" "nasa;owlpddlprobs" "nasa;demoActions"
 "nasa;agents-and-axioms" "nasa;actions" "nasa;demoActions2"
 "demos;YSP" "demos;forall" "demos;path-planning"
 "demos;transportation-function-test" "demos;blocks;rblocks"
 "demos;blocks;htn" "demos;blocks;mea"
 "demos;blocks;mea-object-fluents" "demos;blocks;multi-agent"
 "demos;eBay;ebay" "demos;pddl3.1-examples;Depot"
 "demos;pddl3.1-examples;Depot-new" "demos;pddl3.1-examples;logistics"
 "demos;pddl3.1-examples;logistics-new" "computer;windows"
 "computer;websearch" "computer;computer" "computer;unix"
 "computer;network" "computer;internet" "computer;CAPA;computer-1"
 "computer;infosec;malware" "computer;infosec;PreAttack"
 "computer;infosec;attack;ATTetCK" "computer;infosec;attack;AVOIDIT"
 "computer;infosec;attack;hacker" "computer;infosec;attack;newAttack"
 "computer;infosec;attack;hacker-1" "computer;infosec;attack;spam"
 "computer;infosec;attack;privilegeEscalation"
 "computer;infosec;attack;cg" "computer;infosec;attack;attack"
 "computer;infosec;attack;cna" "computer;infosec;attack;c2"
 "computer;infosec;attack;exfiltration" "afsat;satattnums"
 "afsat;sbss" "afsat;satanml" "afsat;sat" "afsat;demoActions"
 "afsat;satres" "transportation;land-movement" "transportation;ground"
 "transportation;transportation" "transportation;road-network"
 "transportation;water" "transportation;travel" "transportation;air"
 "terrorism;DHSInfrastructure" "terrorism;terrorist" "DoD;dod1"
 "DoD;actionsNew" "DoD;problemsOld" "DoD;actionsOld" "DoD;problems2"
 "DoD;DoDi" "DoD;problemsNew" "DoD;base" "DoD;actions2"
 "DoD;demoActions" "DoD;agents-and-axioms" "DoD;actions"
 "DoD;problems" "DoD;DoD-base" "NAS;NAS-base" "NAS;base" "NAS;NASi"
 "NAS;agents-and-axioms" "NAS;actions" "NAS;problems" "NAS;nas1"
 "Geography;Geography" "Geography;wgs84_pos" "spacecraft;SpaceCrafti"
 "spacecraft;base" "spacecraft;agents&axioms"
 "spacecraft;owlpddlprobs" "spacecraft;SpaceCraft-base"
 "spacecraft;demoActions" "spacecraft;agents-and-axioms"
 "spacecraft;actions" "spacecraft;spacecraft1" "military;weapon"
 "military;D-day" "military;ATO_Ontology"))

(setq 3t-frdcsa-working-loadables
 '("CBRN;RTS-AI;Iran" "demos;path-planning" "demos;eBay;ebay"))

(defun 3t-frdcsa-choose-domain-file ()
 ""
 (interactive)
 (let* ((result (completing-read "Choose Loadable: " 3t-frdcsa-loadables nil t "CBRN;RTS-AI;Iran")))
  (if (subsetp (list result) 3t-frdcsa-loadables :test 'equal)
   (ffap (concat "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/planner/domains/"   (join "/" (split-string result ";")) ".pddl")))))

(defun 3t-frdcsa-choose-domain (&optional loadables-list)
 ""
 (interactive)
 (let* ((result (completing-read "Choose Loadable: " (or loadables-list 3t-frdcsa-loadables) nil t "CBRN;RTS-AI;Iran")))
  (if (subsetp (list result) 3t-frdcsa-loadables :test 'equal)
   (concat "ap: (load \"ap:domains;" result ".pddl\")")
   (error nil))))

;; "ap: (load \"ap:domains;" item ".pddl\")"

(defun 3t-frdcsa-generate-plan-for-load-any-domain ()
 (concat
  "(progn "
  (3t-frdcsa-choose-domain)
  " (setf *problem* (first (problems *domain*))) (run-ap *problem*))"))

(defun 3t-frdcsa-generate-plan-for-load-any-known-working-domain ()
 (concat
  "(progn "
  (3t-frdcsa-choose-domain 3t-frdcsa-working-loadables)
  " (setf *problem* (first (problems *domain*))) (run-ap *problem*))"))

(setq 3t-frdcsa-plans
 '(
   ;; tautologically work
   ("Load From Working Domains" .
    ('3t-frdcsa-generate-plan-for-load-any-known-working-domain))

   ;; actually work
   ("Demos (works)" .
    ("(run-demos))"))
   ("Iran Demo (works)" .
    ("(progn ap: (load \"ap:domains;CBRN;RTS-AI;Iran.pddl\") (setf *problem* (first (problems *domain*))) (run-ap *problem*))"))
   
   ("Nasa" .
 ;;    ("(progn ap: (load \"ap:domains;nasa;nasa2.pddl\") 
;; (DEFINE (PROBLEM DONE-JOBS) (:DOMAIN NASA-DOMAIN) (:SITUATION PHALCON-EVA) (:DEADLINE 200.0)
;;    (:GOAL (JOBS-DONE SALLY BOB)))
;; (setf *problem* \"done-jobs\") (run-ap *problem*))")

    ("(progn ap: (load \"ap:domains;nasa;nasa2.pddl\") (setf *problem* \"assist-sally\") (run-ap *problem*))")
    )

   ;; trivially work
   ("load-pddl (trivially working)" . 
    ("ap: (load-pddl)"))

   ;; don't work
   ("Multi-Agent Demo" . 
    ("(progn ap: (load-pddl) 48 (run-again) 2)"))
   ("DoD1 Demo" .
    ("(progn ap: (load-pddl) 90 ap: (load-pddl) 94 ap: (load-pddl) 98)"))

   ;; allows to choose, some working, some not
   ("Load Any Domain" .
    ('3t-frdcsa-generate-plan-for-load-any-domain))))

;; (setq 3t-frdcsa-plans
;;  '(("Load Any Domain" .
;;     ('3t-frdcsa-choose-domain
;;      "(setf *problem* (first (problems *domain*)))"
;;      "(run-ap *problem*)"
;;      ))
;;    ("load-pddl (trivially working)" . 
;;     ("ap: (load-pddl)"))
;;    ("Multi-Agent Demo" . 
;;     ("ap: (load-pddl)"
;;      "48"
;;      "(run-again)"
;;      "2"))
;;    ("Iran Demo (works)" .
;;     ("ap: (load \"ap:domains;CBRN;RTS-AI;Iran.pddl\")"
;;      "(setf *problem* (first (problems *domain*)))"
;;      "(run-ap *problem*)"
;;      ))
;;    ("DoD1 Demo" .
;;     ("ap: (load-pddl)"
;;      "90"
;;      "ap: (load-pddl)"
;;      "94"
;;      "ap: (load-pddl)"   
;;      "98"
;;      ))))


;; (defvar 3t-frdcsa-init-code-1 nil)
;; (setq 3t-frdcsa-init-code-1
;;  (list
;;   "cl-user: (load-system 'ap :compile t)"
;;   "cl-user: (in-package :ap)"
;;   ))
;; (defvar 3t-frdcsa-init-code-2 nil)
;; (setq 3t-frdcsa-init-code-2
;;  (list
;;   "(defun split-re (arg1 arg2) \"\" (split-regexp arg1 arg2))"
;;   "(defun replace-re (arg1 arg2 arg3) \"\" (replace-regexp arg1 arg2 arg3))"
;;   ))

(defvar 3t-frdcsa-init-code nil)
(setq 3t-frdcsa-init-code
 (list
  "(progn cl-user: (load-system 'ap :compile t) cl-user: (in-package :ap) (defun split-re (arg1 arg2) \"\" (split-regexp arg1 arg2)) (defun replace-re (arg1 arg2 arg3) \"\" (replace-regexp arg1 arg2 arg3)))"
  ))

(defun 3t-frdcsa-launcher-restart ()
 ""
 (interactive)
 (3t-frdcsa-kill)
 (3t-frdcsa-launcher))

(defun 3t-frdcsa-launcher ()
 ""
 (interactive)
 (if (kmax-buffer-exists-p 3t-frdcsa-3t-buffer)
  (switch-to-buffer 3t-frdcsa-3t-buffer)
  (progn
   (run-in-shell
    "cd /var/lib/myfrdcsa/codebases/minor/3t-frdcsa/scripts && ./3t-launch-planner.sh"
    3t-frdcsa-3t-buffer)
   ;; (mapcar
   ;;  #'3t-frdcsa-run-allegro-command-with-prompt
   ;;   3t-frdcsa-init-code-2)
   )))

(defun 3t-frdcsa-launch-if-not-running ()
 ""
 (if (not (kmax-buffer-exists-p 3t-frdcsa-3t-buffer))
  (3t-frdcsa-launcher)))

(defun 3t-frdcsa-plan-restart ()
 ""
 (interactive)
 (3t-frdcsa-kill)
 (3t-frdcsa-plan))

(defun 3t-frdcsa-plan-restart-lad ()
 ""
 (interactive)
 (3t-frdcsa-kill t)
 (3t-frdcsa-plan "Load Any Domain"))

  ;; (3t-frdcsa-plan-loader
  ;;  (append 3t-frdcsa-init-code
  ;;   (see (cdr (assoc "Load Any Domain" 3t-frdcsa-plans)) 0.1)))

(defun 3t-frdcsa-plan (&optional name-arg)
 ""
 (interactive)
 (let ((name
	(or name-arg
	 (completing-read
	  "Plan: "
	  3t-frdcsa-plans))))
  (3t-frdcsa-plan-loader
   (append 3t-frdcsa-init-code
    (see (cdr (assoc name 3t-frdcsa-plans)) 0.1)))))

(defun 3t-frdcsa-plan-loader (plan)
 (interactive)
 (3t-frdcsa-launch-if-not-running)
 (mapcar
  #'3t-frdcsa-run-allegro-command-with-prompt
  plan))

(defun 3t-frdcsa-kill (&optional auto-approve)
 ""
 (interactive)
 (if (or auto-approve (y-or-n-p (concat "Kill 3t?: ")))
   (kmax-kill-buffer-no-ask 3t-frdcsa-3t-buffer)))

(defun 3t-frdcsa-run-allegro-command-with-prompt (command-arg)
 (interactive)
 (let* ((command
	 (if (functionp (eval command-arg))
	  (see (funcall (eval command-arg)) 0.1)
	  (if (stringp command-arg)
 	   (see command-arg 0.1)
 	   (error nil)))))
  (3t-frdcsa-run-command command)))

(defun 3t-frdcsa-run-command (command)
 (if (y-or-n-p (concat "Run this command: (" command ")? "))
  (progn
   (switch-to-buffer 3t-frdcsa-3t-buffer)
   (insert command)
   (comint-send-input))
  (error nil)))

;; (kmax-search-files
;;  "command line arguments"
;;  3t-frdcsa-listing)

;; (setq 3t-frdcsa-listing
;;  (kmax-grep-list 
;;   (kmax-grep-list-regexp
;;    (kmax-find-name-dired "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/doc" "*")
;;    "[^~]$")
;;   #'kmax-non-directory-file))

(defun 3t-frdcsa-search-allegro-documentation (&optional search-arg)
 ""
 (interactive)
 (let* ((search (or search-arg (read-from-minibuffer "Search?: "))))
  (run-in-shell
   (concat "grep -RE "
    (shell-quote-argument search) " "
    (shell-quote-argument 3t-frdcsa-acl81-documentation-dir))
   "*3t-frdcsa Search Allegro Documentation*")))

(defun 3t-frdcsa-search-3t-planner-lisp-files (&optional search-arg)
 ""
 (interactive)
 (3t-frdcsa-search-3t "*3t-frdcsa ACL8.1 3t Lisp Files Search*" "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/planner"))

(defun 3t-frdcsa-search-3t-planner-documentation (&optional search-arg dir)
 (interactive)
 (3t-frdcsa-search-3t "*3t-frdcsa ACL8.1 3t Documentation Search*" "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/planner/doc"))

(defun 3t-frdcsa-search-3t-allegro-lisp-files (&optional search-arg)
 ""
 (interactive)
 (3t-frdcsa-search-3t "*3t-frdcsa ACL8.1 Lisp Files Search*" "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81"))

(defun 3t-frdcsa-search-3t-allegro-documentation (&optional search-arg dir)
 (interactive)
 (3t-frdcsa-search-3t "*3t-frdcsa ACL8.1 Documentation Search*" "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/doc"))

(defun 3t-frdcsa-search-3t (buffer-name dir &optional search-arg)
 ""
 (interactive)
 (let* ((search (or search-arg (read-from-minibuffer "Search?: "))))
  (run-in-shell
   (concat
    "find " dir " -follow  | grep -i '\.lisp$' | xargs grep -iE "
    (shell-quote-argument search))
   buffer-name)))

(defun 3t-frdcsa-search-allegro-documentation-issue (&optional search-arg)
 ""
 (interactive)
 (let* ((dir 3t-frdcsa-acl81-documentation-dir)
	(search (or search-arg (read-from-minibuffer "Search?: "))))
  (kmax-search-files
   search
   (kmax-grep-list
    (kmax-grep-list-regexp
     (kmax-find-name-dired dir "*")
     "[^~]$")
    #'kmax-non-directory-file)
   "*3t-frdcsa ACL8.1 Doc Search*"
   "-i"
   " | grep -v \"function init\" ")
  (delete-other-windows)))

(defun 3t-frdcsa-open-allegro-documentation-startup (&optional search-arg)
 ""
 (interactive)
 (w3m-find-file "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/doc/startup.htm"))

(defun 3t-frdcsa-open-ap-documentation (&optional search-arg)
 ""
 (interactive)
 (w3m-find-file "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/planner/doc/INDEX.html"))
 
(load-if-exists "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/acl81/eli/fi-site-init")

(setq 3t-frdcsa-working-loadables
 '("CBRN;RTS-AI;Iran" "demos;path-planning" "demos;eBay;ebay"))


