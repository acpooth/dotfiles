#!/usr/bin/env sh

# Comprueba si Hyprland tiene alguna ventana de Emacs abierta
if hyprctl clients | grep "class: Emacs"; then
    # Si existe, la trae al frente (la enfoca) y luego lanza org-capture
    hyprctl dispatch focuswindow "class:Emacs"
    emacsclient --eval "(org-capture)" &
else
    # Si no existe, abre una ventana nueva (-c) con org-capture
    emacsclient -c --eval "(org-capture)" &
fi
