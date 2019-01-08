;; -*- Mode: LISP; Syntax: ANSI-COMMON-LISP; Package: CL-USER -*- 
;; :ld  ~/code/3t/trunk/planner/load-ap
;;(load "/home/bonasso/code/3t/trunk/planner/registry/ap.translations")
;; (load "/var/lib/myfrdcsa/codebases/minor/3t-frdcsa/planner-working/registry/ap-defsystem.lisp")
(setf *enable-package-locked-errors* nil)
(load-system 'ap :compile t)
(set-case-mode :case-insensitive-upper)

;;; Only partially useful
;;;
;;;   try (print-prop prop)    CE, 5/27/09
(defun make-english-from-prop (prop)
  (cond ((or (> (length prop) 3)(< (length prop) 2))
	 prop)
	((< (length prop) 3)
	 (format nil "~a is ~a ~a" 'planner (first prop)(second prop)))
	(t (format nil "~a is ~a ~a" (second prop)(first prop)(third prop)))))


;;; The following is now available as ap:display-plan-details  CE 5/27/09

(defun petes-plan-display (plan-root &optional (indent 0))
  (format t "~%")
  (let ((space-string (loop for i from 0 to indent
			  with str = ""
			  do
			    (setf str (concatenate 'string str " "))
			  finally (return str)))
	expansion-word)
    (loop for slot in `(ap::name ap::purpose ap::plot ap::subactions ap::constraints ap::pc-by
				 ap::designators ap::starttime ap::latest-starttime ap::estimated-duration ap::endtime)
	if (and (slot-exists-p plan-root slot)
		(slot-boundp plan-root slot))
	do
	  (cond ((eq slot 'ap::plot)
		 (format t "~%~a~a is ~a" space-string slot (slot-value plan-root slot))
		 (setf expansion-word (first (slot-value plan-root slot))))
		((and (or (eq slot 'ap::designators) ;; agents are designators
			  (eq slot 'ap::constraints))
		      (null (slot-value plan-root slot)))
		 (format t "~%~aThere are no ~a" space-string slot))
		((and (eq slot 'ap::designators)
		      (slot-value plan-root slot))
		 (format t "~%~a~a are: " space-string slot)
		 (loop for des in (slot-value plan-root slot)
		     do
		       (format t "~%  ~a~a = ~a" space-string des (ap::possible-values des))))
		(t (format t "~%~a~a ~[is ~;are~] ~a" 
			   space-string slot  (if (or (eq slot 'ap::purpose)
						      (atom (slot-value plan-root slot))
						      (= (length (slot-value plan-root slot)) 1)) 0 1) 
			   (slot-value plan-root slot))
		   ;;;(format t "~% ~a~a is ~a" space-string slot (slot-value plan-root slot))
		   )))
    (when (and (slot-exists-p plan-root 'ap::propositions)
	     (slot-boundp plan-root 'ap::propositions))
      (format t "~%  ~aProps are ~a" space-string (ap::map-a-hash (ap::propositions plan-root)))
      #|
      (loop for prop in (ap::map-a-hash (ap::propositions plan-root))
	  do
	  (format t "~%   ~a~a" space-string (make-english-from-prop prop)))
	  |#
      )
    (if (and (slot-exists-p plan-root 'ap::facts)
	     (slot-boundp plan-root 'ap::facts))
	(format t "~%  ~aFacts are ~a" space-string (ap::map-a-hash (ap::facts plan-root))))
    (if expansion-word (format t "~%~%  ~a~a" space-string expansion-word))
    (if (and (slot-exists-p plan-root 'ap::subactions)
	     (slot-boundp plan-root 'ap::subactions))
	(loop for subaction in (ap::subactions plan-root)
	    do
	      (petes-plan-display (eval subaction) (+ indent 3))))
    ))


(in-package :ap)
;;(load "AP:demos;blocks;blocks.pddl")
(load "AP:demos;blocks;multi-agent.pddl")
;;(print-plan (run-ap sussman))
(print-plan (run-ap medium-on-light))
(in-package :cl-user)

(petes-plan-display (AP:PLAN-ROOT AP:*PROBLEM*))

(require 'orblink)
(corba:idl "/home/APuser/code/3t/trunk/planner/apgui.idl")

#|
For the idl of a plan GUI

typedef sequence<string> ListStrings;

struct proposition {
 string relation;
 ListStrings args;
 };

typedef sequence<proposition> ListProps;
enum expansion {SERIES, SIMULTANEOUS, UNORDERED, PARALLEL};

struct plot {
 expansion expansion;
 ListProps props;
 };

typedef sequence<any> ListAnys;
 
struct designator{
 string name;
 ListAnys possible_values;
 };

typedef sequence<designators> ListDesignators;

struct plan_node {
 string name;
 proposition purpose;
 plot plot;
 ListProps constraints;
 ListDesignators agents;
 ListProps propositions;
 ListProps facts;
 ListNodes subactions;
};

typedef sequence<plan_node> ListNodes;
















struct leafAction {
 
 string name;
 string purpose;
 string planner;
 ListStrings agents;
};

typedef sequence<leafAction> Expansion	;

// this is also the top level of a plan
struct plan_node {
 string name;
 string purpose;
 string planner;
 ListStrings agents;
 Expansion plot;
};

void postPlan


CL-USER(25): (AP:PRINT-PLAN AP:*PROBLEM*)
SERIES52: ON(MEDIUM)=LIGHT
  series
    SHOVE3: ON(HEAVY)=TABLE
    PUT-ON9: ON(LIGHT)=HEAVY
      series
        GRASP11: HOLDING(LIGHT)
        LIFT-OFF-TABLE19: ON(LIGHT)=NOTHING
        PLACE-ON-SOMETHING21: ON(LIGHT)=HEAVY
    PUT-ON23: ON(MEDIUM)=LIGHT
      series
        DROP-AND-GRASP30: HOLDING(MEDIUM)
          series
            RELEASE38: HOLDING(NOTHING)
            GRASP46: HOLDING(MEDIUM)
        LIFT-OFF-TABLE49: ON(MEDIUM)=NOTHING
        PLACE-ON-SOMETHING51: ON(MEDIUM)=LIGHT
NIL

2     (LOAD "/home/APuser/code/3t/trunk/planner/load-ap")
3     AP:*DOMAIN*
4     (DESCRIBE *)
5     AP:*PROBLEM*
6     (DESCRIBE *)
7     (AP::GOAL AP:*PROBLEM*)
8     (DESCRIBE *)
9     (AP::SHOW-PLAN AP:*PROBLEM*)
10    :reset
11    (AP:PRINT-PLAN AP:*PROBLEM*)
12    (AP:PLAN-ROOT AP:*PROBLEM*)
13    (DESCRIBE *)

The plan-root of a probem is an ap::combined-operation which is an operator with conditional probability and plot triplets.
An operator is an action which has actionrelation, plot, plot-subactions, subactions and subgoals.
An action is a plan-node which has constraints, purpose input & output situations, planner and execution-status and tons of other stuff.
A plan-node is a standard object with lots of relation slots like covers, follows. precedes, etc.

14    :his
CL-USER(15): (ap::subnodes (AP:PLAN-ROOT AP:*PROBLEM*))
(<LEAF 1 AP::SERIES52> <LEAF 2 AP::SERIES52> <LEAF 3 AP::SERIES52>)
CL-USER(16): (ap::purpose (AP:PLAN-ROOT AP:*PROBLEM*))
(ON MEDIUM LIGHT)
CL-USER(17): (describe (first (ap::subnodes (AP:PLAN-ROOT AP:*PROBLEM*))))
(<LEAF 1 AP::SERIES52> <LEAF 2 AP::SERIES52> <LEAF 3 AP::SERIES52>) is a NEW CONS.

Subnodes is a method to get either subactions or plot-subactions from an action or an operator.
The above is a list of plot-nodes which are plan-nodes.

CL-USER(18): (describe (first (ap::subnodes (AP:PLAN-ROOT AP:*PROBLEM*))))
CL-USER(21): (DESCRIBE (second (AP::SUBNODES (AP:PLAN-ROOT AP:*PROBLEM*))))

|#
