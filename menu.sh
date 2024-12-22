#!/bin/bash

# Funktion til at vise menuen
show_menu() {
    clear
    echo "Vælg en kommando fra listen:"
    echo "1) List filer (ls) i en mappe"
    echo "2) Vis diskplads (df -h)"
    echo "3) Se systemoplysninger (uname -a)"
    echo "4) Vis netværkskonfiguration (ip a)"
    echo "5) Se aktive processer (ps aux)"
    echo "6) Ping en IP eller URL"
    echo "7) Kør en nmap scanning"
    echo "8) Hent en URL med curl"
    echo "9) Git status"
    echo "10) Se CPU model (lscpu | grep -i model)"
    echo "11) Liste USB-enheder (lsusb)"
    echo "12) Liste PCI-enheder (lspci)"
    echo "13) Opret SSH-forbindelse"
    echo "14) Opdater systemet (debian, ubuntu)"
    echo "15) Installer en pakke med apt"
    echo "16) Er jeg online?"
    echo "q) Afslut"
}

# Funktion til at udføre kommandoer
run_command() {
    case $1 in
        1)
            read -p "Indtast sti til mappen, der skal listes (tryk Enter for nuværende mappe): " dir
            dir=${dir:-.}  # Hvis input er tomt, brug nuværende mappe
            if [ -d "$dir" ]; then
                echo "List filer i $dir:"
                ls -lah "$dir"
            else
                echo "Mappen $dir findes ikke."
            fi
            ;;
        2)
            echo "Vis diskplads:"
            df -h
            ;;
        3)
            echo "Se systemoplysninger:"
            uname -a
            ;;
        4)
            echo "Vis netværkskonfiguration:"
            ip a
            ;;
        5)
            echo "Se aktive processer:"
            ps aux
            ;;
        6)
            read -p "Indtast IP eller URL til ping: " target
            echo "Pinger $target..."
            ping -c 4 $target
            ;;
        7)
            read -p "Indtast IP eller URL til nmap scanning: " target
            echo "Kører nmap scanning på $target..."
            nmap $target
            ;;
        8)
            read -p "Indtast URL til at hente med curl: " url
            echo "Henter $url..."
            curl $url
            ;;
        9)
            echo "Kører git status:"
            git status
            ;;
        10)
            echo "Se CPU model:"
            lscpu | grep -i model
            ;;
        11)
            echo "Liste USB-enheder:"
            lsusb
            ;;
        12)
            echo "Liste PCI-enheder:"
            lspci
            ;;
        13)
            read -p "Indtast værtsnavn eller IP til SSH-forbindelse: " ssh_target
            echo "Opretter forbindelse til $ssh_target..."
            ssh $ssh_target
            ;;
        14)
            echo "Opdaterer systemet..."
            sudo apt update && sudo apt upgrade -y
            ;;
        15)
            read -p "Indtast navnet på pakken, der skal installeres: " package
            echo "Installerer pakken $package..."
            sudo apt update && sudo apt install -y $package
            ;;
        16)
            echo "Pinger tester forbindelse til DNS-server..."
            ping -c 4 1.1.1.1 > /dev/null 
            if [ $? -eq 0 ]; then
                echo "Forbindelse til DNS-server OK."
            else
                echo "Forbindelse til DNS-server mislykkedes."
            fi
            echo "Pinger google.com..."
            ping -c 4 google.com > /dev/null
            if [ $? -eq 0 ]; then
                echo "Forbindelse til google.com OK."
            else
                echo "Forbindelse til google.com mislykkedes."
            fi
            gateway=$(ip route | grep default | awk '{print $3}')
            echo "Pinger gateway ($gateway)..."
            ping -c 4 $gateway > /dev/null
            if [ $? -eq 0 ]; then
                echo "Forbindelse til gateway OK."
            else
                echo "Forbindelse til gateway mislykkedes."
            fi
            echo "Pinger localhost..."
            ping -c 4 localhost > /dev/null
            if [ $? -eq 0 ]; then
                echo "Forbindelse til localhost OK."
            else
                echo "Forbindelse til localhost mislykkedes."
            fi    
            ;;
        q)
            echo "Afslutter..."
            exit 0
            ;;
        *)
            echo "Ugyldigt valg!"
            ;;
    esac

    # Vent på, at brugeren trykker en tast
    read -n 1 -s -p "Tryk på en vilkårlig tast for at fortsætte..."
    echo
}

# Main loop
while true; do
    show_menu
    read -p "Indtast dit valg [1-16 eller q]: " choice

    # Hvis choice ikke er gyldigt
    if [[ ! "$choice" =~ ^[1-9]$|^1[0-6]$|^q$ ]]; then
        echo "Ugyldigt valg! Prøv igen."
        continue
    fi

    run_command $choice
done