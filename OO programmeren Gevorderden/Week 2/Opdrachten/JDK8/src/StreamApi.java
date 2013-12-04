import java.util.Comparator;
import java.util.List;
import java.util.function.Function;

import static java.util.Arrays.stream;
import static java.util.stream.Collectors.toList;

/**
 * Created by xaviergeerinck on 20/11/13.
 */
public class StreamApi {
    public static void main(String[] args) {
        String[] names = {"GivenName", "Georgios", "Annemijn", "Rowan", "Ikrame", "Teunie", "Faisa", "Jouri", "Mitchel", "Robyn", "Rajni", "Albertus", "Aaron", "Dennes", "Douwe", "Dirkjan", "Edanur", "Cemre", "Fatma", "Meindert", "Timmy", "Serano", "Rafaëla", "Suman", "Fadoua", "Rachael", "Sergio", "Abbey", "Renier", "Adnane", "Betsy", "Saapke", "Desiree", "Oussama", "Coco", "Kaj", "Amelia", "Jihane", "Xynthia", "Hala", "Fady", "Wissam", "Ike", "Anthony", "Mandy", "Jerre", "Jaydan", "Fidan", "Logan", "Irina", "Wart", "Marika", "Sharella", "Yarnick", "Silas", "Jillian", "Safa", "Asmara", "Yigit", "Miles", "Wiecher", "Jozina", "Driesje", "Caesar", "Maurice", "Tirza", "Buck", "Cathérine", "Tracy", "Marcelo", "Prya", "Rochelle", "Patricia", "Gwenny", "Jayme", "Wail", "Bastijn", "Mirthe", "Silvy", "Melvin", "Zenzi", "Victor", "Lucian", "Fabricio", "Rimke", "Nadieh", "Hebe", "Leora", "Steffanie", "Levina", "Aïcha", "Ishani", "Ruveyda", "Krystian", "Laury", "Amke", "Gokhan", "Verona", "Nienke", "Bent", "Maryse", "Tobie", "Ludo", "Leena", "Marielle", "Vinny", "Danielle", "Caroline", "Sharief", "Jady", "Manel", "Mariska", "Dieudonnée", "Tonny", "Cliff", "Chantelle", "Nimet", "Pamela", "Wierd", "Jornt", "Runa", "Armanda", "Lyn", "Annemiek", "Arjun", "Oda", "Anne-Marieke", "Asiya", "Coenradus", "Gezinus", "Jonatan", "Jorinda", "Sjimmie", "Bernice", "Daan", "Ino", "Nandi", "Karlien", "Iddo", "Sandor", "Dax", "Josefine", "Gülizar", "Ranil", "Delphine", "Pip", "Jeroen", "Raúl", "Ina", "Ugur", "Mylène", "Cyrus", "Ouahiba", "Eske", "Shaira", "Danni", "Misja", "Fadila", "Laquisha", "Tijme", "Elliot", "Mechteld", "Rayane", "Seraja", "Genelva", "Muriel", "Omri", "Dyami", "Aliya", "Rishi", "Sai", "Hermen", "Lucie", "Pawan", "Nihal", "Libaan", "Latif", "Sacha", "Aernout", "Evren", "Morten", "Zenab", "Thari", "Geordy", "Feyza", "Nikola", "Elvire", "Gonnie", "Rozemarie", "Lubbert", "Hillie", "Ludwina", "Lizelotte", "Jascha", "Rayane", "Renuka", "Cathleen", "Franklin", "Lian", "Warner", "Kitty", "Tonnie", "Reitze", "Fabien", "Feike", "Tanno", "Abderrazak", "Marino", "Godefridus", "Ömer", "Judy", "Tiamo", "Merlin", "Rodrigo", "Lennaert", "Menno", "Marlein", "Clinton", "Muharrem", "Soufian", "Sharifa", "Jasmin", "Chafik", "Houdaifa", "Dirkjan", "Céline", "Nico", "Soeraya", "Jens", "Joya", "Ulbe", "Ibtisam", "Medine", "Meryl", "Theresa", "Yessica", "Henrie", "Donnie", "Flory", "Loyd", "Youness", "Meinte", "Nanko", "Louisa", "Roeline", "Naila", "Manar", "Janno", "Frederick", "Ihsan", "Jasmien", "Cassandra", "Kristina", "Cherida", "Elbert", "Alec", "Nik", "Linne", "Ferrie", "Neline", "Edita", "Daryl", "Carlijne", "Frouwke", "Esmiralda", "Gaby", "Kimo", "Djenna", "Nikita", "Selcuk", "Roberto", "Henk-Jan", "Hamid", "Eddie", "Shanice", "Babs", "Farisha", "Zoe", "Jorick", "Mariano", "Bedirhan", "Bjørn", "Saartje", "Harrison", "Mickel", "Puck", "Jans", "Sieger", "Resa", "Loes", "Lucille", "Ercan", "Israe", "Sytske", "Gilmar", "Ümmügülsüm", "Tibbe", "Meaghan", "Ismaïl", "Aidan", "Rabiya", "Roos-Anne", "Pelle", "Tyrone", "Sena", "Janette", "Simeon", "Jord", "Johny", "Vanja", "Marianne", "Farisha", "Nathalja", "Cyril", "Monika", "Blanca", "Marle", "Jeanique", "Lotta", "Keenan", "Floyd", "Frens", "Karien", "Fenneke", "Nemo", "Josja", "Ronny", "Aad", "Güllü", "Dragan", "Trijntje", "Gerrie", "May", "Aartje", "Gerhardus", "Serina", "Quirien", "Imad", "Odilia", "Gert", "Roëlle", "Miranda", "Brechtje", "Winesh", "Josia", "Aschwin", "Hafssa", "Mason", "Donovan", "Tugay", "Luka", "Benedict", "Chabeli", "Ary", "Amila", "Theo", "Olaf", "Kubilay", "Wenda", "Ciro", "Darcy", "Enola", "Felix", "Melisa", "Dilber", "Pepita", "Hieke", "Ferris", "Sunny", "Ramon", "Nouaman", "Cihangir", "Lein", "Tomasz", "Bastijn", "Joséphine", "Luut", "Daphne", "Denzell", "Percy", "Sena", "Tyara", "Donatella", "Delia", "Rudie", "Delia", "Smaïl", "Teunis", "Livia", "Usama", "Rafke", "Harm-Jan", "Şebnem", "Merit", "Jelisa", "Minke", "Manu", "Admir", "Hayati", "Yee", "Rudger", "Lennert", "Imadeddine", "Tanja", "Enrico", "Thiemo", "Markus", "Ankie", "Manolito", "Carolus", "Houssam", "Rahul", "Dorina", "Robert-Jan", "Khouloud", "Bing", "Maggy", "Brian", "Dinh", "Nizar", "Franky", "Anas", "Dora", "Vittorio", "Démi", "Çağri", "Safira", "Esmaralda", "Elianne", "Jeroen", "Yalda", "Khallil", "Jitte", "Houssam", "Willie", "Jorian", "Lorenza", "Dorothée", "Badreddine", "Mac", "Sharan", "Cacharel", "Waldo", "Jasmin", "Tjibbe", "Jilke", "Mevlüt", "Charlize", "Marius", "Barbara", "Nimo", "Raïsa", "Angelino", "Naime", "Dian", "Randy", "Emese", "Reindert", "Yonca", "Solaiman", "Prisilla", "Viet", "Marilva", "Aantje", "Loren", "Marion", "Clint", "Geertruda", "Juliano", "Curtis", "Lazlo", "Kaleb", "Delina", "Anniko", "Jantiene", "Thelma", "Anne-Wil", "Darryl", "Bernadine", "Theunis", "Kelvin", "Ymke", "Massimo", "Mingus", "Liset", "Miguel", "Maryn", "Cherrel", "Leena", "Donna", "Kira", "Hilbert", "Pamela", "Mona", "Adriënne", "Stefan", "Morris", "Renato", "Sergen", "Peer", "Bruna", "Binc", "Lieselotte", "Robina", "Romaisa", "Miron", "Chabeli", "Dimphina", "Mervin", "Catarina", "Ashley", "Laurent", "Servé", "Kaltoum", "Serhan", "Roelie", "Sjirk", "Nevil", "Hira", "Marchiano", "Josie", "Yonis", "Ioannis", "Jerry", "Chi", "Menno", "Miraç", "Richenel", "Gonnie", "Ravish", "Manish", "Anaïs", "Gitta", "Sean", "Ceylin", "Sujata", "Wietse", "Herjan", "Devon", "Adam", "Selina", "Roelof", "Mickey", "Warsame", "Gregory", "Betül", "Owen", "Wietske", "Lise", "Louwrens", "Daan", "Zerrin", "Miraç", "Egemen", "Edwinus", "Daisy", "Ilze", "Çiğdem", "Jikke", "Florentius", "Servé", "Heavenly", "Holly", "Ouail", "Mariah", "Liduina", "Nassim", "Therese", "Birgit", "Spike", "Carianne", "Yannick", "Nuria", "Basma", "Orhun", "Albina", "Misty", "Yücel", "Dionysia", "Dirk-Jan", "Maral", "Fiona", "Syreeta", "Smail", "Noam", "Bogdan", "Resul", "Sjaak", "Mèlanie", "Adham", "Chad", "Josephine", "Mellanie", "Jordie", "Lars", "Marjelle", "Pleun", "Santusha", "Étienne", "Brecht", "Zenab", "Marisa", "Dylano", "Ysbrand", "Isolde", "Camille", "Angelique", "Adriënne", "Abdelouahid", "Tony", "Andrea", "Leeroy", "Kean", "Alijda", "Nele", "Arco", "Markus", "Kristin", "Tonny", "Jort", "John", "Wilson", "Yaro", "Serano", "Johann", "Michon", "Lin", "Şaban", "Kerwin", "Ihab", "Chi", "Billie", "Sanja", "Maikel", "Marli", "Dane", "Patrice", "Loraine", "Keo", "Zohal", "Carien", "Darcy", "Josip", "Milos", "Cherissa", "Annejet", "Bella", "Alexandru", "Rodger", "Rozerin", "Louwrens", "Enna", "Soukaina", "Melati", "Annieck", "Wing", "Gijsje", "Niel", "Davud", "Ruth", "Oğuz", "Erin", "Shi", "Hannes", "Sagal", "Najia", "Zena", "Raemon", "Dante", "Enna", "Leyla", "Sin", "Semmy", "Noel", "Nevil", "Dorus", "Annalisa", "Kader", "Houssain", "Goossen", "Roeline", "Tan", "Miron", "Jafeth", "Quintijn", "Harriëtte", "Bünyamin", "Judit", "Sieme", "Faiza", "Ulrike", "Frederica", "Arzu", "Carel", "Joost", "Steijn", "Tunahan", "Ulrike", "Devanté", "Lois", "Fadoua", "Sjuul", "Nenad", "Gilliano", "Soufiane", "Kit", "Anh", "Lorna", "Pepe", "Bastiana", "Puja", "Renatus", "Conner", "Mijndert", "Rochdi", "Laurence", "Veysel", "Nejla", "Lynda", "Wouterus", "Dante", "Melvin", "Sona", "Sohaila", "Emke", "Elia", "Yarnick", "Rafi", "Melis", "Stevie", "Terry", "Abraham", "Frederico", "Morrison", "Rémy", "Geke", "Akira", "Van", "Desiré", "Xin", "Youssri", "Iskander", "Tuncay", "Gwendolyn", "Shabana", "Teije", "Baris", "Craig", "Jef", "Sharan", "Darya", "Pauliene", "Amani", "Ferhan", "Boas", "Tamimount", "Jozephus", "Nidal", "Naim", "Ayan", "Channa", "Lance", "Djamila", "Flemming", "Ivar", "Artur", "Sjirk", "Sjouke", "Robi", "Jordie", "Yelina", "Giovannie", "Dali", "Jona", "Yonne", "Remy", "Lorenzo", "Janske", "Yori", "Derck", "Imrane", "Bodil", "Kristijan", "Crispijn", "Yuri", "Cornelus", "Binne", "Reintje", "Ernestine", "Charlize", "Roelofje", "Shayla", "Marilyn", "Debra", "Emirhan", "Stefan", "Sanne", "Rainier", "Vanya", "Arife", "Osman", "Thom", "Jadie", "Raveena", "Kevin", "Gülçin", "Atze", "Peter", "Benita", "Joseph", "Koendert", "Jamairo", "Amel", "Teunisje", "Rowdy", "Anis", "Ciske", "Tyler", "Manar", "Justen", "Toufik", "Ikram", "Saad", "Jorian", "Meindert", "Hayat", "Franciscus", "Dyon", "Maxwell", "Kajol", "Annabel", "Krzysztof", "Sura", "Andres", "Sertan", "Mirelle", "Henriëtte", "Davy", "Marja", "Fer", "Tren", "Yassine", "Christiane", "Najia", "Denzel", "Guust", "Sjoukje", "Rosaline", "Elmas", "Shaina", "Tom", "Tamika", "Deni", "Maris", "Amke", "Riëlle", "Lilith", "Isobel", "Shazia", "Mücahid", "Moësha", "Luus", "Amarens", "Elien", "Aike", "Yvon", "Selcuk", "Ho", "Arzu", "Annelie", "Ümit", "Muharrem", "Hannan", "Djonno", "Zoya", "Raouf", "Jany", "Angelina", "Nassima", "Raynor", "Carlina", "Sefa", "Tonnie", "Scott", "Reijer", "Nitin", "Zino", "Zoëy", "Milko", "Didem", "Sjoukje", "Niesje", "Kjelt", "Yusra", "Keira", "Rody", "Bieke", "Dhiradj", "Jorine", "Tommie", "Shane", "Niesje", "Aydan", "Ela", "Ceciel", "Florien", "Madelyn", "Rikkert", "Julika", "Katarzyna", "Hanae", "Martijn", "Juul", "Lucca", "Janne", "Nazan", "Annefleur", "Royce", "Juanita", "Bogdan", "Elske", "Beatrix", "Yoshi", "Willem-Jan", "Jacoba", "Hacı", "Tijs", "Ennio", "Ilene", "Berkan", "Baki", "Gijsbert", "Ismahan", "Boyan", "Jeremiah", "Cloé", "Hamida", "Kajal", "Lamiae", "Talha", "Bryce", "Huib", "Davinia", "Berivan", "Lyam", "Feyzullah", "Alfonso", "Sharen", "Carel", "Amro", "Jesse", "Naómi", "Aden", "Fauve", "Josephien", "Zuhal", "Tyron", "Odette", "Bedirhan", "Suat", "Martien", "Theodor", "Wilmer", "Lodewijk", "Bjarn", "Robbert-Jan", "Giordano", "Muhsin", "Laurence", "Solveig", "Sidar", "Kayra", "Marriët", "Bonita", "Joffrey", "Dyami", "Lou", "Annemarie", "Sayenne", "Belle", "Aleida", "Asmae", "Lori", "Dima", "Ennio", "Silvan", "Janco", "Niesje", "Matthias", "Muhittin", "Latife", "Zohal", "Diona", "Lisa", "Esmee", "Marinke", "Jamy", "Jovi", "Raynor", "Karen", "Ursula"};

        List<String> filteredNames1 = stream(names)
                .filter(c -> c.contains("dan"))
                .collect(toList());

        List<String> filteredNames2 = stream(names)
                .filter(c -> c.contains("x"))
                .collect(toList());

        List<String> filteredNames3 = stream(names)
                .filter(c -> c.length() == 3)
                .collect(toList());

        List<String> filteredNames4 = stream(names)
                .filter(c -> c.length() == 5)
                .collect(toList());

        List<String> filteredNames5 = stream(names)
                .filter(c -> c.startsWith("Ge"))
                .collect(toList());

        System.out.println(filteredNames1);
        System.out.println(filteredNames2);
        System.out.println(filteredNames3);
        System.out.println(filteredNames4);
        System.out.println(filteredNames5);
    }
}
