# Web-based SCORE4 παιχνίδι

Περιγραφή του API 


/board				GET 		Επιστρέφει σε json την κατάσταση του board 				200 (OK), 400 (Bad Request)
								εκείνη τη στιγμή
					
/board				POST		Φέρνει το board στην αρχική του κατάσταση 				200 (OK), 400 (Bad Request)

/board/piece/(x,y)		GET		Επιστρέφει σε json την κατάσταση του κελιού(x,y)		200 (OK), 400 (Bad Request)

/board/piece/(x,y)		PUT		Εισάγει το πιόνι στην θέση (x,y). Επιστρέφει τη 		200 (OK), 400 (Bad Request)
								νέα κατάσταση του κελιού (x,y).
								
/players(p)			GET		Επιστρέφει σε json το όνομα(χρώμα) του παίκτη (Y ή R)		200 (OK), 400 (Bad Request)

/players			GET		Επιστρέφει σε json τα στοιχεία των παικτών				200 (OK), 400 (Bad Request)

/status				GET		Επιστρέφει σε json το status του παιχνιδιού				200 (OK), 400 (Bad Request)

---------------------------------------------------------------------------------------------------------------------

Περιγραφή του παιχνιδιού

1.Αρχικά θα πρέπει να οριστεί στην βάση στον πίνακα players τα πεδία player_color με τιμές Y και R και όλα τα υπόλοιπα null.

2.Στον πίνακα game_status το πεδίο status = not active και τα υπόλοιπα null.

3.Όταν μπαίνει ο πρώτος παίκτης πρέπει να δώσει username,να διαλέξει χρώμα και να πατήσει 'είσοδος στο παιχνίδι'. Αφού γίνει αυτό, το status γίνεται initialized.

4.Την ίδια διαδικασία πρέπει να κάνει και ο δεύτερος παίκτης και το status γίνεται started.

5.Στην συνέχεια, το σύστημα αποφασίζει ποιος να παίξει πρώτος και εμφανίζει στον ανάλογο παίκτη το div για το input της κίνησης και το κουμπί 'κανε τη κινηση'.

6.Αφού πατηθεί το κουμπι εξαφανίζεται τα input της κινησης, εισάγεται το πιόνι στην θέση που έδωσε ο χρήστης αλλάζει αυτόματα η σειρα και εμφανίζονται τα input της κινησης στον αλλο παικτη.

7.Το κουμπί 'έναρξη' επαναφέρει το board στην αρχική του κατάσταση.







								
