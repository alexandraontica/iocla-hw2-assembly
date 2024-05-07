*Onțică Alexandra-Elena - 311CB*

# Tema 2 - Intrusion Detection with Suricata

## Task 1 - Permissions

Pentru acest task am verificat dacă pentru fiecare bit setat din n (partea cu permisiuni) există, pe aceeași poziție, bit setat și în permisiunile furnicii cu id-ul din n.

Am extras id-ul furnicii din n și am salvat într-un registru valoarea din ant_permissions care conține permisiunile furnicii cu id-ul extras, eliminând apoi id-ul furnicii din n (ca să nu verific la pasul următor și acești biți). Am parcurs apoi bit cu bit n (cererile de rezervare) și permisiunile furnicii. Dacă bitul din n este 1 și cel din permisiuni 0, funcția se încheie. Dacă se parcurg cererile până la final, înseamnă cu furnica are permisiuni pentru toate camerele cerute.

## Task 2 - Requests
Ca să am o logică clară înainte să scriu codul în assembly, am rezolvat acest task mai întâi în C, folosindu-mă de structurile definite în *check_requests.c*.

### Exercițiul 1

void sort_requests(struct request *requests, int len) {
    int i, j;
    struct request temp;

    for (i = 0; i < len - 1; i++) {
        for (j = i + 1; j < len; j++) {
            if (requests[j].admin == 1 && requests[i].admin == 0) {
                temp = requests[i];
                requests[i] = requests[j];
                requests[j] = temp;
            } else if (requests[j].admin == requests[i].admin) {
                if (requests[i].prio > requests[j].prio) {
                    temp = requests[i];
                    requests[i] = requests[j];
                    requests[j] = temp;
                } else if (requests[i].prio == requests[j].prio) {
                    int k = 0, rez;

                    while (requests[i].login_creds.username[k] != '\0' &&
                           requests[j].login_creds.username[k] != '\0' && 
                           requests[i].login_creds.username[k] == 
                           requests[j].login_creds.username[k]) {
                        k++;
                    }

                    if (requests[i].login_creds.username[k] < 
                        requests[j].login_creds.username[k]) {
                        rez = -1;
                    } else if (requests[i].login_creds.username[k] >
                               requests[j].login_creds.username[k]) {
                        rez = 1;
                    } else {
                        rez = 0;
                    }

                    if (rez > 0) {
                        temp = requests[i];
                        requests[i] = requests[j];
                        requests[j] = temp;
                    }
                }
            }
        }
    }
}

Pentru rezolvarea exercițiului am transformat acest cod în assembly; la sortarea username-urilor am modificat puțin algoritmul ca să îmi ușurez viața.
Sortarea (logica din spate) nu a fost deloc complicată, dar implementarea în assembly a fost... o experiență.

### Exercițiul 2

void check_passkeys(struct request *requests, int len, char *connected) {
    int i;

    // initializare vector connected
    for (i = 0; i < len; i++) {
        connected[i] = 0;
    }

    for (i = 0; i < len; i++) {
        unsigned short pass = requests[i].login_creds.passkey;

        if ((pass & 0x8001) == 0x8001) { // daca are primul si ultimul bit setați
            int num_even_bits = 0, num_odd_bits = 0;

            // calculez numărul biților de 1 dintre următorii 7 biți
            unsigned short temp = pass;
            temp >>= 1;
            for (int j = 0; j < 7; j++) {
                if (temp & 1) {
                    num_even_bits++;
                }
                temp >>= 1;
            }

            // calculez numărul biților de 1 dintre următorii 7 biți
            temp = pass;
            temp >>= 8;
            for (int j = 0; j < 7; j++) {
                if (temp & 1) {
                    num_odd_bits++;
                }
                temp >>= 1;
            }

            // verific daca numarul de biti setati verifica conditiile din exercitiu
            if (num_even_bits % 2 == 0 && num_odd_bits % 2 == 1) {
                connected[i] = 1;
            }
        }
    }
} 

La fel ca la exercițiul 1, verificarea în sine (logica) nu a fost complicată, implementarea în assembly a fost mai grea (dar mai ok ca la sortare totuși :) ).

## Task 3 - Treyfer

La acest exercițiu am implementat pașii descriși, folosindu-mă și de pagina de Wikipedia menționată în cerință pentru algoritmi (https://en.wikipedia.org/wiki/Treyfer).

Tot ce am făcut aici a fost să transform acești algorimi din C în assembly.
Pentru că la fiecare index (când am accesat un element din text/key) am calculat `index % block_size`, am folosit în loc de 2 for-uri o singură „buclă” (simulată cu jump-uri) și la criptare și la decriptare. Rezultatul nu se modifică.

## Task 4 - Labyrinth

După ce te prinzi cum să accesezi un element din matrice acest task nu este chiar atât de complicat.
În C:

 `matrice[linie][coloana] = *(*(matrice + linie) + coloana)`

Așa am accesat elementele matricei și în assembly.

Așa cum este sugerat și în cerință, poziția curentă am marcat-o de fiecare dată cu 1 ca să nu mă întorc din drum.
Am verificat fiecare celulă vecină, având grijă ca aceasta să existe (dacă sunt pe marginea de sus, de exemplu, nu există vecinul de deasupra). Dacă am gasit un vecin egal cu 0, am actualizat poziția în labirint. Algoritmul se oprește când indicele liniei este egal cu *m - 1* sau indicele coloanei este egal cu *n - 1*.
