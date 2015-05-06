∇ license
'APL program to convert Gregorian dates'
'to French Revolutionary dates and the other way'
'Copyright (C) 2015 Jean Forget'
''
' This program is distributed under the same terms as Perl 5.16.3:'
' GNU Public License version 1 or later and Perl Artistic License'
''
' You can find the text of the licenses in the LICENSE file or at'
' http://www.perlfoundation.org/artistic_license_1_0'
' and http://www.gnu.org/licenses/gpl-1.0.html.'
''
' Here is the summary of GPL:'
''
' This program is free software; you can redistribute it and/or modify'
' it under the terms of the GNU General Public License as published by'
' the Free Software Foundation; either version 1, or (at your option)'
' any later version.'
''
' This program is distributed in the hope that it will be useful,'
' but WITHOUT ANY WARRANTY; without even the implied warranty of'
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'
' GNU General Public License for more details.'
''
' You should have received a copy of the GNU General Public License'
' along with this program; if not, write to the Free Software Foundation,'
' Inc., <http://www.fsf.org/>.'
∇
∇ R ← year D
R ← D +.× 1 0 0
∇
∇ R ← month D
R ← D +.× 0 1 0
∇
∇ R ← day D
R ← D +.× 0 0 1
∇
∇ R ← zerojanvnd Y
R ← Y ∘.× 1 0 0
R ← R + (⍴R) ⍴ 0 1 0
∇
∇ R ← fr2rd DATE
R ← 654019 + (frbis year DATE) + DATE +.× 365 30 1
∇
∇ R ← frbis YEAR
YEAR ← YEAR - 1
R ← - / ⌊ YEAR ∘.÷ 4 100 400 4000
R ← R + YEAR ∈ 3 7 11 15
∇
∇ R ← gr2rd DATE; DIM
DIM ← ⍴ DATE
DATE←(DIM ⍴0 1 0) + DATE + (2≥month DATE) ∘.× ¯1 12 0
R ← ¯428 + (-/ ⌊ (year DATE) ∘.÷ 4 100 400) + ⌊DATE +.× 365 30.6 1
∇
∇ R ← rd2fr N; N1
N1 ← N - 654414
YH ← ⌈ N1 ÷ 365.24
YL ← ⌈ N1 ÷ 365.34
YI ← 0 , ⍳ ⌈/,YH-YL
YR ← YL ∘.+ YI
DR ← zerojanvnd YR
NR ← fr2rd DR
CM ← NR < N ∘.+ (⍴YI)⍴0
Y ← ⌈/YR×CM
D ← N - ⌈/NR×CM
M ← ⌈D÷30
D ← D - 30 × M - 1
R ← (Y ∘.× 1 0 0) + (M ∘.× 0 1 0) + D ∘.× 0 0 1
∇
∇ R ← rd2gr N
YH ← ⌈ N ÷ 365.24
YL ← ⌈ N ÷ 365.25
YI ← 0 , ⍳ ⌈/,YH-YL
YR ← YL ∘.+ YI
DR ← zerojanvnd YR
NR ← gr2rd DR
CM ← NR < N ∘.+ (⍴YI)⍴0
Y ← ⌈/YR×CM
D ← N - ⌈/NR×CM
ML ← ⌈D÷31
MR ← ML ∘.+ 0 1
DR ← (Y ∘.× 2 3 ⍴ 1 0 0) + (MR ∘.× 0 1 0)
NR ← gr2rd DR
CM ← NR < N ∘.+ 0 0
M ← ⌈/MR×CM
D ← N - ⌈/NR×CM
R ← (Y ∘.× 1 0 0) + (M ∘.× 0 1 0) + D ∘.× 0 0 1
∇
∇ R ← gr2fr D
R ← rd2fr gr2rd D
∇
∇ R ← fr2gr D
R ← rd2gr fr2rd D
∇
∇ R ← prtfr D
DAY ← 10 8 ⍴ 'Décadi  Primidi Duodi   Tridi   QuartidiQuintidiSextidi Septidi Octidi  Nonidi  '
R ← DAY[⎕IO + 10 | day D;]
MONTH ← 13 11 ⍴ 'VendémiaireBrumaire   Frimaire   Nivôse     Pluviôse   Ventôse    Germinal   Floréal    Prairial   Messidor   Thermidor  Fructidor  jour compl.'
R ← R, ' ', (⍕ day D), ' ', (MONTH[month D;]), ' ', (roman year D), ', jour ', feasts[¯30 + D +.× 0 30 1;]
CM ← ' ' ≠ R
R ← (CM ∨ 0,¯1↓CM) / R
R ← (⌽∨\⌽R≠' ')/R
∇
∇ R ← roman N; NODES
→ ((N>0) ∧ N<4000)/CONV
R ← ⍕ N
→ 0
CONV:
NODES ← 40 4 ⍴ (nodes 'IVX'), (nodes 'XLC'), (nodes 'CDM'), nodes 'M??'
R ← ,NODES[31 21 11 1 + 10 10 10 10 ⊤ N;]
R ← (R≠' ')/R
∇
∇ R ← nodes CH
R ← (' ', CH) [ ' IVX' ⍳ '    I   II  III IV  V   VI  VII VIIIIX  ' ]
∇
∇ R ← feasts
⍝ include here the contents of feasts
V ← ''
⍝ Vendémiaire
V ← V, 'du Raisin            '
V ← V, 'du Safran            '
V ← V, 'de la Châtaigne      '
V ← V, 'de la Colchique      '
V ← V, 'du Cheval            '
V ← V, 'de la Balsamine      '
V ← V, 'de la Carotte        '
V ← V, 'de l''Amarante        '
V ← V, 'du Panais            '
V ← V, 'de la Cuve           '
V ← V, 'de la Pomme de terre '
V ← V, 'de l''Immortelle      '
V ← V, 'du Potiron           '
V ← V, 'du Réséda            '
V ← V, 'de l''Âne             '
V ← V, 'de la Belle de nuit  '
V ← V, 'de la Citrouille     '
V ← V, 'du Sarrasin          '
V ← V, 'du Tournesol         '
V ← V, 'du Pressoir          '
V ← V, 'du Chanvre           '
V ← V, 'de la Pêche          '
V ← V, 'du Navet             '
V ← V, 'de l''Amaryllis       '
V ← V, 'du Bœuf              '
V ← V, 'de l''Aubergine       '
V ← V, 'du Piment            '
V ← V, 'de la Tomate         '
V ← V, 'de l''Orge            '
V ← V, 'du Tonneau           '
⍝ Brumaire
V ← V, 'de la Pomme          '
V ← V, 'du Céleri            '
V ← V, 'de la Poire          '
V ← V, 'de la Betterave      '
V ← V, 'de l''Oie             '
V ← V, 'de l''Héliotrope      '
V ← V, 'de la Figue          '
V ← V, 'de la Scorsonère     '
V ← V, 'de l''Alisier         '
V ← V, 'de la Charrue        '
V ← V, 'du Salsifis          '
V ← V, 'de la Macre          '
V ← V, 'du Topinambour       '
V ← V, 'de l''Endive          '
V ← V, 'du Dindon            '
V ← V, 'du Chervis           '
V ← V, 'du Cresson           '
V ← V, 'de la Dentelaire     '
V ← V, 'de la Grenade        '
V ← V, 'de la Herse          '
V ← V, 'de la Bacchante      '
V ← V, 'de l''Azerole         '
V ← V, 'de la Garance        '
V ← V, 'de l''Orange          '
V ← V, 'du Faisan            '
V ← V, 'de la Pistache       '
V ← V, 'du Macjon            '
V ← V, 'du Coing             '
V ← V, 'du Cormier           '
V ← V, 'du Rouleau           '
⍝ Frimaire
V ← V, 'de la Raiponce       '
V ← V, 'du Turneps           '
V ← V, 'de la Chicorée       '
V ← V, 'de la Nèfle          '
V ← V, 'du Cochon            '
V ← V, 'de la Mâche          '
V ← V, 'du Chou-fleur        '
V ← V, 'du Miel              '
V ← V, 'du Genièvre          '
V ← V, 'de la Pioche         '
V ← V, 'de la Cire           '
V ← V, 'du Raifort           '
V ← V, 'du Cèdre             '
V ← V, 'du Sapin             '
V ← V, 'du Chevreuil         '
V ← V, 'de l''Ajonc           '
V ← V, 'du Cyprès            '
V ← V, 'du Lierre            '
V ← V, 'de la Sabine         '
V ← V, 'du Hoyau             '
V ← V, 'de l''Érable-sucre    '
V ← V, 'de la Bruyère        '
V ← V, 'du Roseau            '
V ← V, 'de l''Oseille         '
V ← V, 'du Grillon           '
V ← V, 'du Pignon            '
V ← V, 'du Liège             '
V ← V, 'de la Truffe         '
V ← V, 'de l''Olive           '
V ← V, 'de la Pelle          '
⍝ Nivôse
V ← V, 'de la Tourbe         '
V ← V, 'de la Houille        '
V ← V, 'du Bitume            '
V ← V, 'du Soufre            '
V ← V, 'du Chien             '
V ← V, 'de la Lave           '
V ← V, 'de la Terre végétale '
V ← V, 'du Fumier            '
V ← V, 'du Salpêtre          '
V ← V, 'du Fléau             '
V ← V, 'du Granit            '
V ← V, 'de l''Argile          '
V ← V, 'de l''Ardoise         '
V ← V, 'du Grès              '
V ← V, 'du Lapin             '
V ← V, 'du Silex             '
V ← V, 'de la Marne          '
V ← V, 'de la Pierre à chaux '
V ← V, 'du Marbre            '
V ← V, 'du Van               '
V ← V, 'de la Pierre à plâtre'
V ← V, 'du Sel               '
V ← V, 'du Fer               '
V ← V, 'du Cuivre            '
V ← V, 'du Chat              '
V ← V, 'de l''Étain           '
V ← V, 'du Plomb             '
V ← V, 'du Zinc              '
V ← V, 'du Mercure           '
V ← V, 'du Crible            '
⍝ Pluviôse
V ← V, 'de la Lauréole       '
V ← V, 'de la Mousse         '
V ← V, 'du Fragon            '
V ← V, 'du Perce-neige       '
V ← V, 'du Taureau           '
V ← V, 'du Laurier-thym      '
V ← V, 'de l''Amadouvier      '
V ← V, 'du Mézéréon          '
V ← V, 'du Peuplier          '
V ← V, 'de la Cognée         '
V ← V, 'de l''Ellébore        '
V ← V, 'du Brocoli           '
V ← V, 'du Laurier           '
V ← V, 'de l''Avelinier       '
V ← V, 'de la Vache          '
V ← V, 'du Buis              '
V ← V, 'du Lichen            '
V ← V, 'de l''If              '
V ← V, 'de la Pulmonaire     '
V ← V, 'de la Serpette       '
V ← V, 'du Thlaspi           '
V ← V, 'du Thymelé           '
V ← V, 'du Chiendent         '
V ← V, 'de la Traînasse      '
V ← V, 'du Lièvre            '
V ← V, 'de la Guède          '
V ← V, 'du Noisetier         '
V ← V, 'du Cyclamen          '
V ← V, 'de la Chélidoine     '
V ← V, 'du Traîneau          '
⍝ Ventôse
V ← V, 'du Tussilage         '
V ← V, 'du Cornouiller       '
V ← V, 'du Violier           '
V ← V, 'du Troène            '
V ← V, 'du Bouc              '
V ← V, 'de l''Asaret          '
V ← V, 'de l''Alaterne        '
V ← V, 'de la Violette       '
V ← V, 'du Marsault          '
V ← V, 'de la Bêche          '
V ← V, 'du Narcisse          '
V ← V, 'de l''Orme            '
V ← V, 'de la Fumeterre      '
V ← V, 'du Vélar             '
V ← V, 'de la Chèvre         '
V ← V, 'de l''Épinard         '
V ← V, 'du Doronic           '
V ← V, 'du Mouron            '
V ← V, 'du Cerfeuil          '
V ← V, 'du Cordeau           '
V ← V, 'de la Mandragore     '
V ← V, 'du Persil            '
V ← V, 'du Cochléaria        '
V ← V, 'de la Pâquerette     '
V ← V, 'du Thon              '
V ← V, 'du Pissenlit         '
V ← V, 'de la Sylvie         '
V ← V, 'du Capillaire        '
V ← V, 'du Frêne             '
V ← V, 'du Plantoir          '
⍝ Germinal
V ← V, 'de la Primevère      '
V ← V, 'du Platane           '
V ← V, 'de l''Asperge         '
V ← V, 'de la Tulipe         '
V ← V, 'de la Poule          '
V ← V, 'de la Blette         '
V ← V, 'du Bouleau           '
V ← V, 'de la Jonquille      '
V ← V, 'de l''Aulne           '
V ← V, 'du Couvoir           '
V ← V, 'de la Pervenche      '
V ← V, 'du Charme            '
V ← V, 'de la Morille        '
V ← V, 'du Hêtre             '
V ← V, 'de l''Abeille         '
V ← V, 'de la Laitue         '
V ← V, 'du Mélèze            '
V ← V, 'de la Ciguë          '
V ← V, 'du Radis             '
V ← V, 'de la Ruche          '
V ← V, 'du Gainier           '
V ← V, 'de la Romaine        '
V ← V, 'du Marronnier        '
V ← V, 'de la Roquette       '
V ← V, 'du Pigeon            '
V ← V, 'du Lilas             '
V ← V, 'de l''Anémone         '
V ← V, 'de la Pensée         '
V ← V, 'de la Myrtille       '
V ← V, 'du Greffoir          '
⍝ Floréal
V ← V, 'de la Rose           '
V ← V, 'du Chêne             '
V ← V, 'de la Fougère        '
V ← V, 'de l''Aubépine        '
V ← V, 'du Rossignol         '
V ← V, 'de l''Ancolie         '
V ← V, 'du Muguet            '
V ← V, 'du Champignon        '
V ← V, 'de la Jacinthe       '
V ← V, 'du Rateau            '
V ← V, 'de la Rhubarbe       '
V ← V, 'du Sainfoin          '
V ← V, 'du Bâton-d''or        '
V ← V, 'du Chamérisier       '
V ← V, 'du Ver à soie        '
V ← V, 'de la Consoude       '
V ← V, 'de la Pimprenelle    '
V ← V, 'de la Corbeille-d''or '
V ← V, 'de l''Arroche         '
V ← V, 'du Sarcloir          '
V ← V, 'du Statice           '
V ← V, 'de la Fritillaire    '
V ← V, 'de la Bourrache      '
V ← V, 'de la Valériane      '
V ← V, 'de la Carpe          '
V ← V, 'du Fusain            '
V ← V, 'de la Civette        '
V ← V, 'de la Buglosse       '
V ← V, 'du Sénevé            '
V ← V, 'de la Houlette       '
⍝ Prairial
V ← V, 'de la Luzerne        '
V ← V, 'de l''Hémérocalle     '
V ← V, 'du Trèfle            '
V ← V, 'de l''Angélique       '
V ← V, 'du Canard            '
V ← V, 'de la Mélisse        '
V ← V, 'du Fromental         '
V ← V, 'du Martagon          '
V ← V, 'du Serpolet          '
V ← V, 'de la Faux           '
V ← V, 'de la Fraise         '
V ← V, 'de la Bétoine        '
V ← V, 'du Pois              '
V ← V, 'de l''Acacia          '
V ← V, 'de la Caille         '
V ← V, 'de l''Œillet          '
V ← V, 'du Sureau            '
V ← V, 'du Pavot             '
V ← V, 'du Tilleul           '
V ← V, 'de la Fourche        '
V ← V, 'du Barbeau           '
V ← V, 'de la Camomille      '
V ← V, 'du Chèvrefeuille     '
V ← V, 'du Caille-lait       '
V ← V, 'de la Tanche         '
V ← V, 'du Jasmin            '
V ← V, 'de la Verveine       '
V ← V, 'du Thym              '
V ← V, 'de la Pivoine        '
V ← V, 'du Chariot           '
⍝ Messidor
V ← V, 'du Seigle            '
V ← V, 'de l''Avoine          '
V ← V, 'de l''Oignon          '
V ← V, 'de la Véronique      '
V ← V, 'du Mulet             '
V ← V, 'du Romarin           '
V ← V, 'du Concombre         '
V ← V, 'de l''Échalotte       '
V ← V, 'de l''Absinthe        '
V ← V, 'de la Faucille       '
V ← V, 'de la Coriandre      '
V ← V, 'de l''Artichaut       '
V ← V, 'de la Giroflée       '
V ← V, 'de la Lavande        '
V ← V, 'du Chamois           '
V ← V, 'du Tabac             '
V ← V, 'de la Groseille      '
V ← V, 'de la Gesse          '
V ← V, 'de la Cerise         '
V ← V, 'du Parc              '
V ← V, 'de la Menthe         '
V ← V, 'du Cumin             '
V ← V, 'du Haricot           '
V ← V, 'de l''Orcanète        '
V ← V, 'de la Pintade        '
V ← V, 'de la Sauge          '
V ← V, 'de l''Ail             '
V ← V, 'de la Vesce          '
V ← V, 'du Blé               '
V ← V, 'de la Chalémie       '
⍝ Thermidor
V ← V, 'de l''Épautre         '
V ← V, 'du Bouillon-blanc    '
V ← V, 'du Melon             '
V ← V, 'de l''Ivraie          '
V ← V, 'du Bélier            '
V ← V, 'de la Prèle          '
V ← V, 'de l''Armoise         '
V ← V, 'du Carthame          '
V ← V, 'de la Mûre           '
V ← V, 'de l''Arrosoir        '
V ← V, 'du Panis             '
V ← V, 'du Salicor           '
V ← V, 'de l''Abricot         '
V ← V, 'du Basilic           '
V ← V, 'de la Brebis         '
V ← V, 'de la Guimauve       '
V ← V, 'du Lin               '
V ← V, 'de l''Amande          '
V ← V, 'de la Gentiane       '
V ← V, 'de l''Écluse          '
V ← V, 'de la Carline        '
V ← V, 'du Câprier           '
V ← V, 'de la Lentille       '
V ← V, 'de l''Aunée           '
V ← V, 'de la Loutre         '
V ← V, 'de la Myrte          '
V ← V, 'du Colza             '
V ← V, 'du Lupin             '
V ← V, 'du Coton             '
V ← V, 'du Moulin            '
⍝ Fructidor
V ← V, 'de la Prune          '
V ← V, 'du Millet            '
V ← V, 'du Lycoperdon        '
V ← V, 'de l''Escourgeon      '
V ← V, 'du Saumon            '
V ← V, 'de la Tubéreuse      '
V ← V, 'du Sucrion           '
V ← V, 'de l''Apocyn          '
V ← V, 'de la Réglisse       '
V ← V, 'de l''Échelle         '
V ← V, 'de la Pastèque       '
V ← V, 'du Fenouil           '
V ← V, 'de l''Épine-vinette   '
V ← V, 'de la Noix           '
V ← V, 'de la Truite         '
V ← V, 'du Citron            '
V ← V, 'de la Cardère        '
V ← V, 'du Nerprun           '
V ← V, 'du Tagette           '
V ← V, 'de la Hotte          '
V ← V, 'de l''Églantier       '
V ← V, 'de la Noisette       '
V ← V, 'du Houblon           '
V ← V, 'du Sorgho            '
V ← V, 'de l''Écrevisse       '
V ← V, 'de la Bagarade       '
V ← V, 'de la Verge-d''or     '
V ← V, 'du Maïs              '
V ← V, 'du Marron            '
V ← V, 'du Panier            '
⍝ jour complémentaire
V ← V, 'de la Vertu          '
V ← V, 'du Génie             '
V ← V, 'du Travail           '
V ← V, 'de l''Opinion         '
V ← V, 'des Récompenses      '
V ← V, 'de la Révolution     '
R ← 366 21 ⍴ V
∇
∇ R ← testdata; V; L
⍝ include here the contents of testapl
V ← ⍳0
V ← V, 1792  9 22    1  1  1  654415
V ← V, 1793 10 23    2  2  2  654811
V ← V, 1794  7 27    2 11  9  655088
V ← V, 1794 11 23    3  3  3  655207
V ← V, 1795 10  5    4  1 13  655523
V ← V, 1795 12 25    4  4  4  655604
V ← V, 1797  1 24    5  5  5  656000
V ← V, 1798  2 24    6  6  6  656396
V ← V, 1799 11  9    8  2 18  657019
V ← V, 1801  3 29    9  7  8  657524
V ← V, 1804  4 30   12  8 10  658652
V ← V, 1807  6  1   15  9 12  659779
V ← V, 1810  7  3   18 10 14  660907
V ← V, 1813  8  4   21 11 16  662035
V ← V, 1816  9  4   24 12 18  663162
V ← V, 2000  1  1  208  4 12  730120
V ← V, 2001  5 11  209  8 22  730616
V ← V, 1792  9 22    1  1  1  654415
V ← V, 1793  9 21    1 13  5  654779
V ← V, 1793  9 22    2  1  1  654780
V ← V, 1794  9 21    2 13  5  655144
V ← V, 1794  9 22    3  1  1  655145
V ← V, 1795  9 22    3 13  6  655510
V ← V, 1795  9 23    4  1  1  655511
V ← V, 1796  9 21    4 13  5  655875
V ← V, 1796  9 22    5  1  1  655876
V ← V, 1797  9 21    5 13  5  656240
V ← V, 1797  9 22    6  1  1  656241
V ← V, 1799  9 22    7 13  6  656971
V ← V, 1799  9 23    8  1  1  656972
V ← V, 1800  9 22    8 13  5  657336
V ← V, 1800  9 23    9  1  1  657337
V ← V, 1801  9 22    9 13  5  657701
V ← V, 1801  9 23   10  1  1  657702
V ← V, 1823  9 22   31 13  5  665736
V ← V, 1823  9 23   32  1  1  665737
V ← V, 1824  9 22   32 13  6  666102
V ← V, 1824  9 23   33  1  1  666103
V ← V, 1825  9 22   33 13  5  666467
V ← V, 1825  9 23   34  1  1  666468
V ← V, 1892  9 21  100 13  5  690938
V ← V, 1892  9 22  101  1  1  690939
V ← V, 1900  9 22  108 13  6  693860
V ← V, 1900  9 23  109  1  1  693861
V ← V, 1992  9 21  200 13  5  727462
V ← V, 1992  9 22  201  1  1  727463
V ← V, 2000  9 21  208 13  6  730384
V ← V, 2000  9 22  209  1  1  730385
V ← V, 2092  9 20  300 13  5  763986
V ← V, 2092  9 21  301  1  1  763987
V ← V, 2100  9 21  308 13  6  766908
V ← V, 2100  9 22  309  1  1  766909
V ← V, 2192  9 21  400 13  6  800511
V ← V, 2192  9 22  401  1  1  800512
V ← V, 2193  9 21  401 13  5  800876
V ← V, 2199  9 22  408  1  1  803068
V ← V, 2200  9 22  408 13  6  803433
V ← V, 2791  9 23 1000  1  1 1019292
V ← V, 2792  9 22 1001  1  1 1019657
V ← V, 3000  1  1 1208  4 12 1095363
V ← V, 3001  1  1 1209  4 11 1095728
V ← V, 3791  9 22 2000  1  1 1384534
V ← V, 3792  9 22 2001  1  1 1384900
V ← V, 4000  1  1 2208  4 12 1460605
V ← V, 4001  1  1 2209  4 12 1460971
V ← V, 4320  9 10 2528 12 24 1577735
V ← V, 4320  9 11 2528 12 25 1577736
V ← V, 4791  9 23 3000  1  1 1749777
V ← V, 4792  9 22 3001  1  1 1750142
V ← V, 5000  1  1 3208  4 12 1825848
V ← V, 5001  1  1 3209  4 11 1826213
V ← V, 5791  9 22 4000  1  1 2115019
V ← V, 5792  9 21 4001  1  1 2115384
V ← V, 6000  1  1 4208  4 13 2191090
V ← V, 6001  1  1 4209  4 13 2191456
V ← V, 6791  9 22 5000  1  1 2480261
V ← V, 6792  9 21 5001  1  1 2480626
V ← V, 7791  9 21 6000  1  1 2845503
V ← V, 7792  9 21 6001  1  1 2845869
L ← (⍴ V) ÷ 7
R ← (L, 7) ⍴ V
∇
∇ R ← teststring; V; L
V ← ''
⍝ include here the contents of testapl1
V ← V, 'Primidi 1 Vendémiaire I, jour du Raisin             '
V ← V, 'Duodi 2 Brumaire II, jour du Céleri                 '
V ← V, 'Nonidi 9 Thermidor II, jour de la Mûre              '
V ← V, 'Tridi 3 Frimaire III, jour de la Chicorée           '
V ← V, 'Tridi 13 Vendémiaire IV, jour du Potiron            '
V ← V, 'Quartidi 4 Nivôse IV, jour du Soufre                '
V ← V, 'Quintidi 5 Pluviôse V, jour du Taureau              '
V ← V, 'Sextidi 6 Ventôse VI, jour de l''Asaret              '
V ← V, 'Octidi 18 Brumaire VIII, jour de la Dentelaire      '
V ← V, 'Octidi 8 Germinal IX, jour de la Jonquille          '
V ← V, 'Décadi 10 Floréal XII, jour du Rateau               '
V ← V, 'Duodi 12 Prairial XV, jour de la Bétoine            '
V ← V, 'Quartidi 14 Messidor XVIII, jour de la Lavande      '
V ← V, 'Sextidi 16 Thermidor XXI, jour de la Guimauve       '
V ← V, 'Octidi 18 Fructidor XXIV, jour du Nerprun           '
V ← V, 'Duodi 12 Nivôse CCVIII, jour de l''Argile            '
V ← V, 'Duodi 22 Floréal CCIX, jour de la Fritillaire       '
V ← V, 'Primidi 1 Vendémiaire I, jour du Raisin             '
V ← V, 'Quintidi 5 jour compl. I, jour des Récompenses      '
V ← V, 'Primidi 1 Vendémiaire II, jour du Raisin            '
V ← V, 'Quintidi 5 jour compl. II, jour des Récompenses     '
V ← V, 'Primidi 1 Vendémiaire III, jour du Raisin           '
V ← V, 'Sextidi 6 jour compl. III, jour de la Révolution    '
V ← V, 'Primidi 1 Vendémiaire IV, jour du Raisin            '
V ← V, 'Quintidi 5 jour compl. IV, jour des Récompenses     '
V ← V, 'Primidi 1 Vendémiaire V, jour du Raisin             '
V ← V, 'Quintidi 5 jour compl. V, jour des Récompenses      '
V ← V, 'Primidi 1 Vendémiaire VI, jour du Raisin            '
V ← V, 'Sextidi 6 jour compl. VII, jour de la Révolution    '
V ← V, 'Primidi 1 Vendémiaire VIII, jour du Raisin          '
V ← V, 'Quintidi 5 jour compl. VIII, jour des Récompenses   '
V ← V, 'Primidi 1 Vendémiaire IX, jour du Raisin            '
V ← V, 'Quintidi 5 jour compl. IX, jour des Récompenses     '
V ← V, 'Primidi 1 Vendémiaire X, jour du Raisin             '
V ← V, 'Quintidi 5 jour compl. XXXI, jour des Récompenses   '
V ← V, 'Primidi 1 Vendémiaire XXXII, jour du Raisin         '
V ← V, 'Sextidi 6 jour compl. XXXII, jour de la Révolution  '
V ← V, 'Primidi 1 Vendémiaire XXXIII, jour du Raisin        '
V ← V, 'Quintidi 5 jour compl. XXXIII, jour des Récompenses '
V ← V, 'Primidi 1 Vendémiaire XXXIV, jour du Raisin         '
V ← V, 'Quintidi 5 jour compl. C, jour des Récompenses      '
V ← V, 'Primidi 1 Vendémiaire CI, jour du Raisin            '
V ← V, 'Sextidi 6 jour compl. CVIII, jour de la Révolution  '
V ← V, 'Primidi 1 Vendémiaire CIX, jour du Raisin           '
V ← V, 'Quintidi 5 jour compl. CC, jour des Récompenses     '
V ← V, 'Primidi 1 Vendémiaire CCI, jour du Raisin           '
V ← V, 'Sextidi 6 jour compl. CCVIII, jour de la Révolution '
V ← V, 'Primidi 1 Vendémiaire CCIX, jour du Raisin          '
V ← V, 'Quintidi 5 jour compl. CCC, jour des Récompenses    '
V ← V, 'Primidi 1 Vendémiaire CCCI, jour du Raisin          '
V ← V, 'Sextidi 6 jour compl. CCCVIII, jour de la Révolution'
V ← V, 'Primidi 1 Vendémiaire CCCIX, jour du Raisin         '
V ← V, 'Sextidi 6 jour compl. CD, jour de la Révolution     '
V ← V, 'Primidi 1 Vendémiaire CDI, jour du Raisin           '
V ← V, 'Quintidi 5 jour compl. CDI, jour des Récompenses    '
V ← V, 'Primidi 1 Vendémiaire CDVIII, jour du Raisin        '
V ← V, 'Sextidi 6 jour compl. CDVIII, jour de la Révolution '
V ← V, 'Primidi 1 Vendémiaire M, jour du Raisin             '
V ← V, 'Primidi 1 Vendémiaire MI, jour du Raisin            '
V ← V, 'Duodi 12 Nivôse MCCVIII, jour de l''Argile           '
V ← V, 'Primidi 11 Nivôse MCCIX, jour du Granit             '
V ← V, 'Primidi 1 Vendémiaire MM, jour du Raisin            '
V ← V, 'Primidi 1 Vendémiaire MMI, jour du Raisin           '
V ← V, 'Duodi 12 Nivôse MMCCVIII, jour de l''Argile          '
V ← V, 'Duodi 12 Nivôse MMCCIX, jour de l''Argile            '
V ← V, 'Quartidi 24 Fructidor MMDXXVIII, jour du Sorgho     '
V ← V, 'Quintidi 25 Fructidor MMDXXVIII, jour de l''Écrevisse'
V ← V, 'Primidi 1 Vendémiaire MMM, jour du Raisin           '
V ← V, 'Primidi 1 Vendémiaire MMMI, jour du Raisin          '
V ← V, 'Duodi 12 Nivôse MMMCCVIII, jour de l''Argile         '
V ← V, 'Primidi 11 Nivôse MMMCCIX, jour du Granit           '
V ← V, 'Primidi 1 Vendémiaire 4000, jour du Raisin          '
V ← V, 'Primidi 1 Vendémiaire 4001, jour du Raisin          '
V ← V, 'Tridi 13 Nivôse 4208, jour de l''Ardoise             '
V ← V, 'Tridi 13 Nivôse 4209, jour de l''Ardoise             '
V ← V, 'Primidi 1 Vendémiaire 5000, jour du Raisin          '
V ← V, 'Primidi 1 Vendémiaire 5001, jour du Raisin          '
V ← V, 'Primidi 1 Vendémiaire 6000, jour du Raisin          '
V ← V, 'Primidi 1 Vendémiaire 6001, jour du Raisin          '
R ← 79 52 ⍴ V
∇
∇ alltests
testfr2rd
testgr2rd
testrd2fr
testrd2gr
testprtfr
∇
∇ testfr2rd
'Checking fr2rd with the full vector, errors: ', ⍕ +/ testdata[;7] ≠ fr2rd testdata[;4 5 6]
test1fr2rd 5 5
test1fr2rd 5 3 3
test1fr2rd 5 2 2 2
∇
∇ test1fr2rd DIM
'Checking fr2rd with dimension ', ⍕ DIM
EXP ← DIM ⍴ testdata[;7]
GOT ← fr2rd (DIM, 3) ⍴ testdata[;4 5 6]
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
'Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
'Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
→ 0
CHKDATA:
'Data errors: ', ⍕ +/,EXP≠GOT
∇
∇ testgr2rd
'Testing gr2rd with the full vector, errors: ', ⍕ +/ testdata[;7] ≠ gr2rd testdata[;1 2 3]
test1gr2rd 5 5
test1gr2rd 5 3 3
test1gr2rd 5 2 2 2
∇
∇ test1gr2rd DIM
'Checking gr2rd with dimension ', ⍕ DIM
EXP ← DIM ⍴ testdata[;7]
GOT ← gr2rd (DIM, 3) ⍴ testdata[;1 2 3]
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
'Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
'Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
→ 0
CHKDATA:
'Data errors: ', ⍕ +/,EXP≠GOT
∇
∇ testrd2fr
'Checking rd2fr with the full vector: errors: ', ⍕ +/∨/ testdata[;4 5 6] ≠ rd2fr testdata[;7]
test1rd2fr 3 3
test1rd2fr 15 3
test1rd2fr 2 3 3
∇
∇ test1rd2fr DIM
'Checking rd2fr with dimension ', ⍕ DIM
EXP ← (DIM, 3) ⍴ testdata[;4 5 6]
GOT ← rd2fr DIM ⍴ testdata[;7]
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
'Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
'Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
→ 0
CHKDATA:
'Data errors: ', ⍕ +/,∨/EXP≠GOT
∇
∇ testrd2gr
'Checking rd2gr with the full vector: errors: ', ⍕ +/∨/ testdata[;1 2 3] ≠ rd2gr testdata[;7]
test1rd2gr 3 3
test1rd2gr 15 3
test1rd2gr 2 3 3
∇
∇ test1rd2gr DIM
'Checking rd2gr with dimension ', ⍕ DIM
EXP ← (DIM, 3) ⍴ testdata[;1 2 3]
GOT ← rd2gr DIM ⍴ testdata[;7]
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
'Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
'Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
→ 0
CHKDATA:
'Data errors: ', ⍕ +/,∨/EXP≠GOT
∇
∇ testprtfr; I; EXP; GOT; N
'Checking prtfr with the full vector'
I ← 0
N ← 0
LOOP:
I ← I + 1
→ (I > (⍴ teststring)[1])/END
EXP ← teststring[I;]
EXP ← (⌽∨\⌽EXP≠' ')/EXP
GOT ← prtfr testdata[I; 4 5 6]
→ ((⍴ EXP)  = ⍴ GOT)/NEXT
'Different length: ', (⍕⍴ EXP), ' ', ⍕⍴GOT
'Expected: ', EXP
'Got     : ', GOT
N ← N + 1
→ LOOP
NEXT:
→ (∧/EXP=GOT)/LOOP
'Different content'
'Expected: ', EXP
'Got     : ', GOT
N ← N + 1
→ LOOP
END:
'Data errors: ', ⍕N
∇
