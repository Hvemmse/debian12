import requests
from bs4 import BeautifulSoup
import csv
from datetime import datetime

# URL til websiden, du vil hente data fra
url = "http://192.168.1.25"

# Send en GET-anmodning til websiden
response = requests.get(url)

# Tjek om anmodningen var succesfuld
if response.status_code == 200:
    # Parse HTML-indholdet
    soup = BeautifulSoup(response.text, "html.parser")

    # Eksempel: Find alle afsnit (<p>) på siden
    paragraphs = soup.find_all("p")

    # Åbn en CSV-fil og tilføj tid og indhold af hvert <p>-element som en række
    with open("output.csv", mode="a", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)

        # Tjek om filen er tom for at tilføje overskrifter kun én gang
        if file.tell() == 0:
            writer.writerow(["Tid", "Afsnit"])  # Skriv kolonneoverskrifter

        for p in paragraphs:
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            writer.writerow([current_time, p.text])  # Skriv tid og <p>-tekst

    print("Data med tidsstempler fra <p>-elementer er tilføjet til output.csv.")
else:
    print("Fejl ved hentning af siden:", response.status_code)