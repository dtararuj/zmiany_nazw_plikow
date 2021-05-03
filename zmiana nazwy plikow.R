library(tidyverse)
library(tidyr)

folder<-"Z:/PREORDER/ZAMÓWIENIA/zdjêcia produktów/2021a"

#zmiana z png na jpg

#najpierw lista nazw plikow
list.files(folder, pattern = "*.png", full.names = TRUE)->stare_nazwy_png

#stworzenie folderu tymczasowego
folder2<-"Z:/PREORDER/ZAMÓWIENIA/zdjêcia produktów/2021a_tymczasowy"
str_replace(stare_nazwy_png,folder, folder2)  %>%  str_remove("png") %>%  paste0("jpg")->nowe_nazwy_po_png

#zamiana nazw, poprzez kopiowanie do innego folderu i zmiana nazwy
file.copy(from = stare_nazwy_png, to = nowe_nazwy_po_png)

#usuniecie zlych plikow
file.remove(stare_nazwy_png)


#skopiowanie plikow do pierwotnego folderu
str_replace(nowe_nazwy_po_png,folder2, folder)  ->nowe_nazwy_po_png_stary_folder

file.copy(from = nowe_nazwy_po_png,to = nowe_nazwy_po_png_stary_folder)
### FALSE pojawi sie gdy juz plik taki jest


#### zmiana nazwy, np plikow 4f, kodow z malej/duzej litery

#znalezienie tych plikow, ktore maja zle nazwy, po jakims patternie
list.files(folder, pattern = "^L1", full.names = TRUE)->zle_nazwy

#pobieram jakis plik gdzie mam w dobrej kolejnosci, wlasciwe nazwy. [najlepiej sobie w ten sposob dac nazwy do podmiany]
dobre_nazwy<- read_csv("C:/Users/C032L/Desktop/indeksy do podmiany.csv")

#przerabiam na wektor
as.vector(dobre_nazwy$`nowy indeks`)->nazwy_do_podmiany

#tworze nowy tymczasowy folder
folder2<-"Z:/PREORDER/ZAMÓWIENIA/zdjêcia produktów/2021a_tymczasowy"

#tworze nowe nazwy do tymczasowego folderu
paste0(folder2,"/",nazwy_do_podmiany,".jpg")->nowe_nazwy_do_podmiany

#zamiana nazw, poprzez kopiowanie do innego folderu i zmiana nazwy
file.copy(from = zle_nazwy, to = nowe_nazwy_do_podmiany)

#usuniecie zlych plikow
file.remove(zle_nazwy)

#skopiowanie plikow do pierwotnego folderu
str_replace(nowe_nazwy_do_podmiany,folder2, folder)  ->nowe_nazwy_stary_folder

file.copy(from = nowe_nazwy_do_podmiany,to = nowe_nazwy_stary_folder)

#usuniecie plikow z folderu tymczasowego
file.remove(nowe_nazwy_do_podmiany)
