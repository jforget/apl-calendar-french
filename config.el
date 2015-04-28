;;; config.el --- inserting APL chars into a buffer
; -*- encoding: utf-8; indent-tabs-mode: nil -*-

;;     Emacs configuration script to help write APL scripts and HTML sequences in hpweb files
;;     Copyright (C) 2015 Jean Forget
;;
;;     This program is distributed under the same terms as Perl 5.16.3:
;;     GNU Public License version 1 or later and Perl Artistic License
;;
;;     You can find the text of the licenses in the F<LICENSE> file or at
;;     L<http://www.perlfoundation.org/artistic_license_1_0>
;;     and L<http://www.gnu.org/licenses/gpl-1.0.html>.
;;
;;     Here is the summary of GPL:
;;
;;     This program is free software; you can redistribute it and/or modify
;;     it under the terms of the GNU General Public License as published by
;;     the Free Software Foundation; either version 1, or (at your option)
;;     any later version.
;;
;;     This program is distributed in the hope that it will be useful,
;;     but WITHOUT ANY WARRANTY; without even the implied warranty of
;;     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;     GNU General Public License for more details.
;;
;;     You should have received a copy of the GNU General Public License
;;     along with this program; if not, write to the Free Software Foundation,
;;     Inc., L<http://www.fsf.org/>.
;;
(progn
(find-file "calendar-french.hpweb")
(html-mode)
(defun apl-insert ()
       "Inserting an APL char"
       (interactive)
                     ; arithmetic     vector          program
                     ; mathematic
  (let* ((apl-conv '(("times"  . "×") ("rho"    . "⍴") ("gets"    . "←")
                     ("div"    . "÷") ("iota"   . "⍳") ("goto"    . "→")
                     ("neg"    . "¯") ("drop"   . "↓") ("del"     . "∇")
                     ("circ"   . "○") ("take"   . "↑") ("lamp"    . "⍝")
                     ("floor"  . "⌊") ("slbar"  . "⌿") ("quad"    . "⎕")
                     ("ceil"   . "⌈") ("slbck"  . "⍀") ("qquad"   . "⍞")
                     ("log"    . "⍟") ("elem"   . "∈") ("enquote" . "⍕")
                     ("domino" . "⌹") ("jot"    . "∘") ("dequote" . "⍎")
                     ("neq"    . "≠") ("transp" . "⍉")
                     ("leq"    . "≤")
                     ("geq"    . "≥")
                     ))
          (ch1 (cdr (assoc (completing-read "Car ? "
                                            (mapcar 'car apl-conv)
                                            nil t)
                            apl-conv))))
     (insert ch1))
)
(global-set-key '[f6] 'apl-insert)
(defun html-plus-grand   () (interactive) (insert "&gt;"))
(defun html-plus-petit   () (interactive) (insert "&lt;"))
(defun html-espace-insec () (interactive) (insert "&nbsp;"))
(defun html-laquo        () (interactive) (insert "«&nbsp;"))
(defun html-raquo        () (interactive) (insert "&nbsp;»"))
(defun html-latex        () (interactive) (insert "L<sup>A</sup>T<sub>E</sub>X"))
(defun html-oelig        () (interactive) (insert "&oelig;"))
(defun html-list-item    () (interactive) (insert "
<li>

</li>
") (next-line -2) (end-of-line))
(defun html-pre-tt       () (interactive) (insert "
<pre type='tt'>

</pre>
") (next-line -2) (end-of-line))

(defun subs-chaine (chaine avant apres lgav)
  "Dans une chaîne principale, substituer une sous-chaîne par une autre, la longueur n'étant pas nécessairement la même"
  (cond
     ((< (length chaine) lgav)  chaine) ; fin de la récursion, la chaîne ne contient assurément pas la chaîne-avant
     ((equal (substring chaine 0 lgav) avant)
        (concat apres                  (subs-chaine (substring chaine lgav) avant apres lgav))) ; remplacement et récursion
     (t (concat (substring chaine 0 1) (subs-chaine (substring chaine    1) avant apres lgav))) ; récursion sans remplacement
  )
)

(defun html-langage (lang) (interactive "slangage ? ") 
	(insert "<i lang='" lang "'></i>")
	(backward-char 4))

(defun html-href-anchor (address) (interactive "sadresse ? ") 
	(insert "<a href='" address "'></a>")
	(backward-char 4))

(defun completer-html-table () (interactive)
  (define-key html-mode-map "\C-c>"      'html-plus-grand)
  (define-key html-mode-map "\C-c<"      'html-plus-petit)
  (define-key html-mode-map "\C-c "      'html-espace-insec)
  (define-key html-mode-map "\C-c\C-c>"  'html-raquo)
  (define-key html-mode-map "\C-c\C-c<"  'html-laquo)
  (define-key html-mode-map "\C-cl"      'html-latex)
  (define-key html-mode-map "\C-co"      'html-oelig)
  (define-key html-mode-map "\C-cp"      'html-pre-tt)
  (define-key html-mode-map "\C-ci"      'html-langage))
(completer-html-table)
(global-font-lock-mode -1)
(mouse-avoidance-mode "proteus")
)
