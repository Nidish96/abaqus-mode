# abaqus-mode
Emacs major-mode for editing Abaqus/Calculix inp files

This builds on top of the abaqus.el by Jorgen Bergstrom (jorgen@polymerfem.com) from PolymerFEM.com .

# Installation:
  Add the following lines to your .emacs file:

    (add-hook 'abaqus-mode-hook 'turn-on-font-lock)
    (autoload 'abaqus-mode "abaqus" "Enter abaqus mode." t)

  Copy this file the emacs site-lisp directory:

     cp abaqus.el [path to emacs site-lisp directory]

# TO DO:
+ Ensure commented lines do NOT fold and are visible at all times
+ Add Snippets
+ Add autocompletion database
