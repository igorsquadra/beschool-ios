# **Progetto Applicazione Mobile - Segreteria Scuola**

## **Contesto del Progetto**

Lo scopo di questo progetto è sviluppare un'applicazione mobile che rappresenti digitalmente una scuola. L'app deve gestire informazioni relative a classi, studenti e professori, utilizzando un'interfaccia utente intuitiva e un design accattivante.

- **Schermata principale**: Elenco delle classi con opzioni per aggiungere, modificare e rimuovere classi. 
- **Detail View delle classi**: Mostra professori e studenti con la possibilità di aggiungerne e modificarne i dettagli.
- **Detail View di professori e studenti**: Mostra informazioni dettagliate con la possibilità di editarle.

---

## **Requisiti Essenziali**

### **1. Backend**
- Connessione tramite API per gestire il database e visualizzare i dati.
- Libertà nella scelta della struttura del database locale e del tipo di database.
- Ogni operazione CRUD deve aggiornare i dati sul backend tramite le API.

### **2. Frontend**
- **Schermata principale**:
  - Elenco delle classi.
  - Opzioni per aggiungere, rimuovere e modificare le classi.
  - Pulsante "Sync" per sincronizzare i dati con il backend.
- **All'avvio**:
  - L'app scarica la lista delle classi e aggiorna il database locale.
- **Schermata dettagli delle classi**:
  - Visualizza professore e alunni associati.
  - Aggiunta, rimozione e modifica degli studenti.
  - Modifica del professore.
- **Schermata dettagli di alunni e professori**:
  - Mostra il profilo dettagliato con la possibilità di modificarlo.
- **Schermata impostazioni**:
  - Opzione per eseguire il logout che elimina il database locale. Al riavvio, i dati vengono ricaricati dal backend.

### **3. Gestione delle Aule**
- Ogni aula deve contenere uno o più studenti.
- Ogni aula deve avere un solo professore associato.
- Ogni professore può insegnare una o più materie.

### **4. Gestione degli Studenti**
- Informazioni richieste per ogni studente:
  - Avatar (link immagine).
  - Nome.
  - Email.
  - Note.

### **5. Gestione dei Professori**
- Informazioni richieste per ogni professore:
  - Avatar (link immagine).
  - Nome.
  - Email.
  - Lista delle materie insegnate.

### **6. Funzionalità di Ricerca**
- Implementare una funzionalità di ricerca per trovare alunni e professori.

### **7. Interfaccia Utente**
- Focus su:
  - Fluidità e semplificazione.
  - Estetica accattivante.
- **UI specifiche**:
  - Gestione delle aule.
  - Dettagli di aule, studenti e professori.
  - Schermata impostazioni.

---

## **Funzionalità Opzionali**
Le seguenti funzionalità non sono richieste, ma sono apprezzate se implementate con attenzione all'estetica e alle prestazioni:
- Compatibilità con dispositivi multipli (smartphone, tablet, Mac, PC).
- **Intro Screen**: Visualizzata al primo avvio o dopo il logout.
- **Altre funzionalità**:
  - Qualsiasi altra feature deve rispettare i principi di prestazioni e design estetico.

---

## **Note Importanti**
- Gli oggetti JSON delle API usano `_id` come chiave identificativa, non `id`.
- I JSON delle risposte possono non includere campi vuoti o nulli.

### **Suggerimenti**
Per generare avatar:
1. [https://api.multiavatar.com/Steve%20Jobs.png](https://api.multiavatar.com/Steve%20Jobs.png)
   - Gratuito, con limite di 10 chiamate al minuto.
2. [https://api.dicebear.com/7.x/avataaars/jpg?seed=Steve%20Jobs](https://api.dicebear.com/7.x/avataaars/jpg?seed=Steve%20Jobs)

---

## **Tempistica**
Il progetto deve essere completato entro **5 giorni lavorativi** dalla data di assegnazione.

---

## **Obiettivo**
L'obiettivo principale è creare un'applicazione che offra:
- **Eccellente esperienza utente**.
- **Design moderno ed esteticamente gradevole**.
- Implementazione corretta delle funzionalità richieste.

---

## **Consegna**
Il progetto finale deve essere consegnato entro la data stabilita tramite una repository Git. La consegna deve includere:
1. Codice sorgente.
2. Documentazione necessaria per avviare l'app su un dispositivo fisico.

---

## **API Backend**

- **BaseURL**: `https://servicetest3.edo.io/school`
- **API Key**: Usare la chiave API fornita via email.

### **Endpoint**
1. `/school/classrooms`
2. `/school/classroom/{id}`

#### **Autenticazione**
Le richieste devono includere:
- **Header**: `Authorization: Bearer {api key}`
- **URL Parameter**: `?access_token={api key}` (se preferito).

#### **Formato**
- **Body**: JSON per operazioni `POST` e `PUT`.
- **ID**: La chiave identificativa è `_id`.
- Campi vuoti o nulli potrebbero non essere presenti.

---


## **Documentazione Tecnica**

### **1. Architettura del Progetto**
L'applicazione segue i principi della **Clean Architecture**, suddivisa in tre moduli principali:

#### **1.1 Modulo UI**
- Contiene le **View** e i **ViewModel**, che si occupano di:
  - Gestire l'interfaccia utente con **SwiftUI**.
  - Fornire dati elaborati dal modulo **Domain**.
  - Interagire con l'utente per operazioni come ricerca, modifica o sincronizzazione.

#### **1.2 Modulo Domain**
- Include la logica di business e le entità principali:
  - **Use Cases**: Definiscono le operazioni principali come:
    - Creazione, modifica e rimozione di aule, professori e studenti.
    - Sincronizzazione dei dati con il backend.
  - **Entity Models**: Rappresentano le entità principali (Classroom, Student, Professor) nel dominio.

#### **1.3 Modulo Data**
- Responsabile della gestione dei dati:
  - **Local Data**:
    - Gestito tramite **SwiftData**.
    - Include la persistenza dei dati localmente.
  - **Remote Data**:
    - Interazioni con le API tramite il **NetworkManager**.
    - Gestione delle operazioni CRUD e sincronizzazione.

---
