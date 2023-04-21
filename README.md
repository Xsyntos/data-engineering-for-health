# data-engineering-for-health
Dit is de github-repostiry voor het individuele onderzoek van Steven Rietberg voor de minor data-engineering-for-health aan de hogeschool Rotterdam. 

## Onderzoek
### inleiding
Voor het bedrijf Officebooking moeten ik en mijn projectgroep onderzoek doen naar hoe wij de datastructuur van hun applicatie kunnen veranderen zodat de datastructuur toekomstbestendig en flexibel is. De nieuwe datastructuur moet onder andere een “best-match” functionaliteit kunnen ondersteunen. Deze functionaliteit houdt in dat als een gebruiker van de Officebooking-applicatie opzoek is naar een kamer hij/zij de meeste geschikte kamer als eerste ziet. Voor dit onderzoek heeft de projectgroep een hoofdvraag met een aantal deelvragen opgesteld. Eén van deze deelvragen pak ik op als hoofdvraag voor mijn individuele onderzoek. Deze deelvraag is: “Welke factoren hebben invloed op de keuze van een datastructuur.”

Voor dit onderzoek is ervoor gekozen om eerst informatie te vergaren doormiddel van een deskresearch om vervolgens deze statements te bevestigen doormiddel van een fieldresearch. Het fieldresearch bestaat uit een aantal testen op een toegepaste vorm van de datastructuur waarover wordt gesproken in de deskresearch. Deze toegepaste vorm bevat een gemaakte ERD en een docker-compose. De toegepaste vorm basseerd zich op een casus die gebruikt is tijdens het hoorcollege over dimensioneel modelleren namelijk de “Retail Case Study” casus (deze is terug te vinden in bijlage I). 

### Fieldresearch
In deze github-repostiry bewaar ik de databases die zijn gebruikt voor het fieldresearch van het onderzoek. Iedere map staat voor een onderzochte datastructuur, in deze mappen zijn de volgende bestanden te vinden

- de map **data**: hier staan de bestanden van de database in.
- **ERD.mwb**: Het ERD gemaakt met MySQL workbench
- **ERD.png**: Het ERD in afbeelding formaat
- **Docker-compose**: Doormiddel van dit bestand kan men gemakkelijk de database met structuur en data lokaal draaien.
- **Onderzoek.SQL**: Hierin staan de SQL querry's in die zijn gebruikt voor het onderzoek. In de comments onder de querry's staan de test resultaten.

## Database lokaal draaien
Om één van de databases lokaal te kunnen draaien moet men het programma [docker installeren](https://docs.docker.com/get-docker/). Men kan maar 1 database tegelijk draaien omdat iedere database gebruikt dezelfde port. Om een database te draaien moet men binnen 1 van de folders het commando **docker-compose up** uit te voeren. Om vervolgens in te loggen op de database heeft men de volgende credentials nodig:

- **Hostname**: localhost
- **Port**: 23306
- **Username**: root
- **Password**: root
- **Database**: mydb

### Onderzoek test
1. Start de database van de gekozen structuur op volgens de uitleg onder het kopje Database lokaal draaien
2. Log vervolgens in via een database manage programma zoals PHPmyadmin of HeidiSQL met de inlog gegevens die hierboven staan.
3. Voer de query die in het bestand **Onderzoek.SQL** uit op de database om de snelheid van de query's te meten. (Het kan zijn dat de waardes erg afwijken van de gemeten waardes, omdat de database op een andere computer draai of de database cached vorige resultaten van de query's)

## Toestemming
De database bevat testdata en het toegestaan om deze repo/databases te gebruiken voor eigen doeleindes, echter het is wel verplicht om een referenties te geven naar deze repo mocht u het gebruiken voor onderzoek/educatie.
