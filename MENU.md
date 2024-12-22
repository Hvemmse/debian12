# Menu Script

Dette script viser en menu med forskellige kommandoer, som brugeren kan vælge imellem. Scriptet er skrevet i Bash og kan bruges til at udføre forskellige systemadministrationsopgaver.

## Funktioner

### `show_menu`
Denne funktion viser en menu med følgende muligheder:
1. List filer (ls) i en mappe
2. Vis diskplads (df -h)
3. Se systemoplysninger (uname -a)
4. Vis netværkskonfiguration (ip a)
5. Se aktive processer (ps aux)
6. Ping en IP eller URL
7. Kør en nmap scanning
8. Hent en URL med curl
9. Git status
10. Se CPU model (lscpu | grep -i model)
11. Liste USB-enheder (lsusb)
12. Liste PCI-enheder (lspci)
13. Opret SSH-forbindelse
14. Opdater systemet (debian, ubuntu)
15. Installer en pakke med apt
16. Er jeg online?
q. Afslut

### `run_command`
Denne funktion udfører den kommando, som brugeren har valgt fra menuen. Den bruger en `case`-struktur til at håndtere de forskellige valg:
- **1)** Lister filer i en specificeret mappe eller den nuværende mappe, hvis ingen sti er angivet.
- **2)** Viser diskplads ved hjælp af `df -h`.
- **3)** Viser systemoplysninger ved hjælp af `uname -a`.
- **4)** Viser netværkskonfiguration ved hjælp af `ip a`.
- **5)** Viser aktive processer ved hjælp af `ps aux`.
- **6)** Pinger en specificeret IP eller URL.
- **7)** Kører en nmap-scanning på en specificeret IP eller URL.
- **8)** Henter en URL ved hjælp af `curl`.
- **9)** Viser git status.
- **10)** Viser CPU model ved hjælp af `lscpu | grep -i model`.
- **11)** Lister USB-enheder ved hjælp af `lsusb`.
- **12)** Lister PCI-enheder ved hjælp af `lspci`.
- **13)** Opretter en SSH-forbindelse til en specificeret værtsnavn eller IP.
- **14)** Opdaterer systemet ved hjælp af `sudo apt update && sudo apt upgrade -y`.
- **15)** Installerer en specificeret pakke ved hjælp af `sudo apt update && sudo apt install -y`.
- **16)** Tjekker om du er online ved at pinge 1.1.1.1, google.com, gateway og localhost.
- **q)** Afslutter scriptet.

### Main loop
Denne del af scriptet viser menuen og læser brugerens valg i en uendelig løkke. Hvis valget er gyldigt, kaldes `run_command`-funktionen med brugerens valg som argument. Hvis valget er ugyldigt, vises en fejlmeddelelse, og brugeren bliver bedt om at prøve igen.

## Brug
For at køre scriptet, skal du have Bash installeret på dit system. Kør følgende kommando for at starte scriptet:

```bash
./menu.sh