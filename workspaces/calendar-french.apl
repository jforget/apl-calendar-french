#!/usr/bin/apl -f
⍝I'm not sure if my modifications change the license 
⍝since I am using GNU APL specific features. Alex Weiner

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
R ← 1 0 0/D
∇
∇ R ← month D
R ← 0 1 0/D
∇
∇ R ← day D
R ← 0 0 1 /D
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
∇ R ← rd2fr N; ⎕IO; N1; YH; YL; YI; YR; DR; NR; CM; Y; M; D
⎕IO ← 1
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
∇ R ← rd2gr N; ⎕IO; YH; YL; YI; YR; DR; NR; CM; Y; M; D; ML; MR
⎕IO ← 1
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
∇ R ← prtfr D; DAY; MONTH; CM; ⎕IO
⎕IO ← 1
DAY ←⊃ ⎕inp 'DAY-end'
Décadi  
Primidi 
Duodi   
Tridi   
Quartidi
Quintidi
Sextidi 
Septidi 
Octidi  
Nonidi
DAY-end

R ← DAY[1 + 10 | day D;]
MONTH← ⊃ ⎕inp 'MONTH-end'
Vendémiaire
Brumaire   
Frimaire   
Nivôse     
Pluviôse   
Ventôse    
Germinal   
Floréal    
Prairial   
Messidor   
Thermidor  
Fructidor  
jour compl.
MONTH-end

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
R ← ,NODES[⎕IO + 30 20 10 0 + 10 10 10 10 ⊤ N;]
R ← (R≠' ')/R
∇
∇ R ← nodes CH
R ← (' ', CH) [ ' IVX' ⍳ '    I   II  III IV  V   VI  VII VIIIIX  ' ]
∇
∇ R ← feasts; V
⍝ include here the contents of feasts

⍝ Vendémiaire
V← ⎕inp 'V-end'
du Raisin
du Safran
de la Châtaigne
de la Colchique
du Cheval            
de la Balsamine      
de la Carotte        
de l'Amarante        
du Panais            
de la Cuve           
de la Pomme de terre 
de l'Immortelle      
du Potiron           
du Réséda            
de l'Âne             
de la Belle de nuit  
de la Citrouille     
du Sarrasin          
du Tournesol         
du Pressoir          
du Chanvre           
de la Pêche          
du Navet             
de l'Amaryllis       
du Bœuf              
de l'Aubergine       
du Piment            
de la Tomate         
de l'Orge            
du Tonneau 
V-end
⍝ Brumaire
V←V, ⎕inp 'V-end'          
de la Pomme          
du Céleri            
de la Poire          
de la Betterave      
de l'Oie             
de l'Héliotrope      
de la Figue          
de la Scorsonère     
de l'Alisier         
de la Charrue        
du Salsifis          
de la Macre          
du Topinambour
du Dindon            
du Chervis           
du Cresson           
de la Dentelaire     
de la Grenade        
de la Herse          
de la Bacchante      
de l'Azerole         
de la Garance        
de l'Orange          
du Faisan            
de la Pistache       
du Macjon            
du Coing             
du Cormier           
du Rouleau 
V-end
⍝ Frimaire
V←V, ⎕inp 'V-end'          
de la Raiponce       
du Turneps           
de la Chicorée       
de la Nèfle          
du Cochon            
de la Mâche          
du Chou-fleur        
du Miel              
du Genièvre          
de la Pioche         
de la Cire           
du Raifort           
du Cèdre             
du Sapin             
du Chevreuil         
de l'Ajonc           
du Cyprès            
du Lierre            
de la Sabine         
du Hoyau             
de l'Érable-sucre    
de la Bruyère        
du Roseau            
de l'Oseille         
du Grillon           
du Pignon            
du Liège             
de la Truffe         
de l'Olive           
de la Pelle   
V-end
⍝ Nivôse
V←V, ⎕inp 'V-end'       
de la Tourbe         
de la Houille        
du Bitume            
du Soufre            
du Chien             
de la Lave           
de la Terre végétale 
du Fumier            
du Salpêtre          
du Fléau             
du Granit            
de l'Argile          
de l'Ardoise         
du Grès              
du Lapin             
du Silex             
de la Marne          
de la Pierre à chaux 
du Marbre            
du Van               
de la Pierre à plâtre
du Sel               
du Fer               
du Cuivre            
du Chat              
de l'Étain           
du Plomb             
du Zinc              
du Mercure           
du Crible        
V-end
⍝ Pluviôse
V←V, ⎕inp 'V-end'   
de la Lauréole       
de la Mousse         
du Fragon            
du Perce-neige       
du Taureau           
du Laurier-thym      
de l'Amadouvier      
du Mézéréon          
du Peuplier          
de la Cognée         
de l'Ellébore        
du Brocoli           
du Laurier           
de l'Avelinier       
de la Vache          
du Buis              
du Lichen            
de l'If              
de la Pulmonaire     
de la Serpette       
du Thlaspi           
du Thymelé           
du Chiendent         
de la Traînasse      
du Lièvre            
de la Guède          
du Noisetier         
du Cyclamen          
de la Chélidoine     
du Traîneau       
V-end
⍝ Ventôse   
V←V, ⎕inp 'V-end'
du Tussilage         
du Cornouiller       
du Violier           
du Troène            
du Bouc              
de l'Asaret          
de l'Alaterne        
de la Violette       
du Marsault          
de la Bêche          
du Narcisse          
de l'Orme            
de la Fumeterre      
du Vélar             
de la Chèvre         
de l'Épinard         
du Doronic           
du Mouron            
du Cerfeuil          
du Cordeau           
de la Mandragore     
du Persil            
du Cochléaria        
de la Pâquerette     
du Thon              
du Pissenlit         
de la Sylvie         
du Capillaire        
du Frêne    
du Plantoir          
V-end
⍝ Germinal
V←V, ⎕inp 'V-end'          
de la Primevère      
du Platane           
de l'Asperge         
de la Tulipe         
de la Poule          
de la Blette         
du Bouleau           
de la Jonquille      
de l'Aulne           
du Couvoir           
de la Pervenche      
du Charme            
de la Morille        
du Hêtre             
de l'Abeille         
de la Laitue         
du Mélèze            
de la Ciguë          
du Radis             
de la Ruche          
du Gainier           
de la Romaine        
du Marronnier        
de la Roquette       
du Pigeon            
du Lilas             
de l'Anémone         
de la Pensée         
de la Myrtille       
du Greffoir    
V-end
⍝ Floréal
V←V, ⎕inp 'V-end'      
de la Rose           
du Chêne             
de la Fougère        
de l'Aubépine        
du Rossignol         
de l'Ancolie         
du Muguet            
du Champignon        
de la Jacinthe       
du Rateau            
de la Rhubarbe       
du Sainfoin          
du Bâton-d'or        
du Chamérisier       
du Ver à soie        
de la Consoude       
de la Pimprenelle    
de la Corbeille-d'or 
de l'Arroche         
du Sarcloir          
du Statice           
de la Fritillaire    
de la Bourrache      
de la Valériane      
de la Carpe          
du Fusain            
de la Civette        
de la Buglosse       
du Sénevé            
de la Houlette
V-end
⍝ Prairial
V←V, ⎕inp 'V-end'       
de la Luzerne        
de l'Hémérocalle     
du Trèfle            
de l'Angélique       
du Canard            
de la Mélisse        
du Fromental         
du Martagon          
du Serpolet          
de la Faux           
de la Fraise         
de la Bétoine        
du Pois              
de l'Acacia          
de la Caille         
de l'Œillet          
du Sureau            
du Pavot             
du Tilleul           
de la Fourche        
du Barbeau           
de la Camomille      
du Chèvrefeuille     
du Caille-lait       
de la Tanche         
du Jasmin            
de la Verveine       
du Thym              
de la Pivoine        
du Chariot   
V-end
⍝ Messidor
V←V, ⎕inp 'V-end'        
du Seigle            
de l'Avoine          
de l'Oignon          
de la Véronique      
du Mulet             
du Romarin           
du Concombre         
de l'Échalotte       
de l'Absinthe        
de la Faucille       
de la Coriandre      
de l'Artichaut       
de la Giroflée       
de la Lavande        
du Chamois           
du Tabac             
de la Groseille      
de la Gesse          
de la Cerise         
du Parc              
de la Menthe         
du Cumin             
du Haricot           
de l'Orcanète        
de la Pintade        
de la Sauge          
de l'Ail             
de la Vesce          
du Blé               
de la Chalémie     
V-end
⍝ Thermidor 
V←V, ⎕inp 'V-end'
de l'Épautre         
du Bouillon-blanc    
du Melon             
de l'Ivraie          
du Bélier            
de la Prèle          
de l'Armoise         
du Carthame          
de la Mûre           
de l'Arrosoir        
du Panis             
du Salicor           
de l'Abricot         
du Basilic           
de la Brebis         
de la Guimauve       
du Lin               
de l'Amande          
de la Gentiane       
de l'Écluse          
de la Carline        
du Câprier           
de la Lentille       
de l'Aunée           
de la Loutre         
de la Myrte          
du Colza             
du Lupin             
du Coton             
du Moulin
V-end
⍝ Fructidor
V←V, ⎕inp 'V-end'            
de la Prune          
du Millet            
du Lycoperdon        
de l'Escourgeon      
du Saumon            
de la Tubéreuse      
du Sucrion           
de l'Apocyn          
de la Réglisse       
de l'Échelle         
de la Pastèque       
du Fenouil           
de l'Épine-vinette   
de la Noix           
de la Truite         
du Citron            
de la Cardère        
du Nerprun           
du Tagette           
de la Hotte          
de l'Églantier       
de la Noisette       
du Houblon           
du Sorgho            
de l'Écrevisse       
de la Bagarade       
de la Verge-d'or     
du Maïs              
du Marron            
du Panier     
V-end
⍝ jour complémentaire
R←⊃V, ⎕inp 'V-end'       
de la Vertu          
du Génie             
du Travail           
de l'Opinion         
des Récompenses      
de la Révolution     
V-end
∇
∇ R ← testdata
⍝ include here the contents of testapl
R← ⊃⍎¨⎕inp 'V-end'
1792  9 22    1  1  1  654415
1793 10 23    2  2  2  654811
1794  7 27    2 11  9  655088
1794 11 23    3  3  3  655207
1795 10  5    4  1 13  655523
1795 12 25    4  4  4  655604
1797  1 24    5  5  5  656000
1798  2 24    6  6  6  656396
1799 11  9    8  2 18  657019
1801  3 29    9  7  8  657524
1804  4 30   12  8 10  658652
1807  6  1   15  9 12  659779
1810  7  3   18 10 14  660907
1813  8  4   21 11 16  662035
1816  9  4   24 12 18  663162
2000  1  1  208  4 12  730120
2001  5 11  209  8 22  730616
1792  9 22    1  1  1  654415
1793  9 21    1 13  5  654779
1793  9 22    2  1  1  654780
1794  9 21    2 13  5  655144
1794  9 22    3  1  1  655145
1795  9 22    3 13  6  655510
1795  9 23    4  1  1  655511
1796  9 21    4 13  5  655875
1796  9 22    5  1  1  655876
1797  9 21    5 13  5  656240
1797  9 22    6  1  1  656241
1799  9 22    7 13  6  656971
1799  9 23    8  1  1  656972
1800  9 22    8 13  5  657336
1800  9 23    9  1  1  657337
1801  9 22    9 13  5  657701
1801  9 23   10  1  1  657702
1823  9 22   31 13  5  665736
1823  9 23   32  1  1  665737
1824  9 22   32 13  6  666102
1824  9 23   33  1  1  666103
1825  9 22   33 13  5  666467
1825  9 23   34  1  1  666468
1892  9 21  100 13  5  690938
1892  9 22  101  1  1  690939
1900  9 22  108 13  6  693860
1900  9 23  109  1  1  693861
1992  9 21  200 13  5  727462
1992  9 22  201  1  1  727463
2000  9 21  208 13  6  730384
2000  9 22  209  1  1  730385
2092  9 20  300 13  5  763986
2092  9 21  301  1  1  763987
2100  9 21  308 13  6  766908
2100  9 22  309  1  1  766909
2192  9 21  400 13  6  800511
2192  9 22  401  1  1  800512
2193  9 21  401 13  5  800876
2199  9 22  408  1  1  803068
2200  9 22  408 13  6  803433
2791  9 23 1000  1  1 1019292
2792  9 22 1001  1  1 1019657
3000  1  1 1208  4 12 1095363
3001  1  1 1209  4 11 1095728
3791  9 22 2000  1  1 1384534
3792  9 22 2001  1  1 1384900
4000  1  1 2208  4 12 1460605
4001  1  1 2209  4 12 1460971
4320  9 10 2528 12 24 1577735
4320  9 11 2528 12 25 1577736
4791  9 23 3000  1  1 1749777
4792  9 22 3001  1  1 1750142
5000  1  1 3208  4 12 1825848
5001  1  1 3209  4 11 1826213
5791  9 22 4000  1  1 2115019
5792  9 21 4001  1  1 2115384
6000  1  1 4208  4 13 2191090
6001  1  1 4209  4 13 2191456
6791  9 22 5000  1  1 2480261
6792  9 21 5001  1  1 2480626
7791  9 21 6000  1  1 2845503
7792  9 21 6001  1  1 2845869
V-end
∇
∇ R ← teststring; V; L
V ← ''
⍝ include here the contents of testapl1
R← ⊃⎕inp 'V-end'
Primidi 1 Vendémiaire I, jour du Raisin             
Duodi 2 Brumaire II, jour du Céleri                 
Nonidi 9 Thermidor II, jour de la Mûre              
Tridi 3 Frimaire III, jour de la Chicorée           
Tridi 13 Vendémiaire IV, jour du Potiron            
Quartidi 4 Nivôse IV, jour du Soufre                
Quintidi 5 Pluviôse V, jour du Taureau              
Sextidi 6 Ventôse VI, jour de l'Asaret              
Octidi 18 Brumaire VIII, jour de la Dentelaire      
Octidi 8 Germinal IX, jour de la Jonquille          
Décadi 10 Floréal XII, jour du Rateau               
Duodi 12 Prairial XV, jour de la Bétoine            
Quartidi 14 Messidor XVIII, jour de la Lavande      
Sextidi 16 Thermidor XXI, jour de la Guimauve       
Octidi 18 Fructidor XXIV, jour du Nerprun           
Duodi 12 Nivôse CCVIII, jour de l'Argile            
Duodi 22 Floréal CCIX, jour de la Fritillaire       
Primidi 1 Vendémiaire I, jour du Raisin             
Quintidi 5 jour compl. I, jour des Récompenses      
Primidi 1 Vendémiaire II, jour du Raisin            
Quintidi 5 jour compl. II, jour des Récompenses     
Primidi 1 Vendémiaire III, jour du Raisin           
Sextidi 6 jour compl. III, jour de la Révolution    
Primidi 1 Vendémiaire IV, jour du Raisin            
Quintidi 5 jour compl. IV, jour des Récompenses     
Primidi 1 Vendémiaire V, jour du Raisin             
Quintidi 5 jour compl. V, jour des Récompenses      
Primidi 1 Vendémiaire VI, jour du Raisin            
Sextidi 6 jour compl. VII, jour de la Révolution    
Primidi 1 Vendémiaire VIII, jour du Raisin          
Quintidi 5 jour compl. VIII, jour des Récompenses   
Primidi 1 Vendémiaire IX, jour du Raisin            
Quintidi 5 jour compl. IX, jour des Récompenses     
Primidi 1 Vendémiaire X, jour du Raisin             
Quintidi 5 jour compl. XXXI, jour des Récompenses   
Primidi 1 Vendémiaire XXXII, jour du Raisin         
Sextidi 6 jour compl. XXXII, jour de la Révolution  
Primidi 1 Vendémiaire XXXIII, jour du Raisin        
Quintidi 5 jour compl. XXXIII, jour des Récompenses 
Primidi 1 Vendémiaire XXXIV, jour du Raisin         
Quintidi 5 jour compl. C, jour des Récompenses      
Primidi 1 Vendémiaire CI, jour du Raisin            
Sextidi 6 jour compl. CVIII, jour de la Révolution  
Primidi 1 Vendémiaire CIX, jour du Raisin           
Quintidi 5 jour compl. CC, jour des Récompenses     
Primidi 1 Vendémiaire CCI, jour du Raisin           
Sextidi 6 jour compl. CCVIII, jour de la Révolution 
Primidi 1 Vendémiaire CCIX, jour du Raisin          
Quintidi 5 jour compl. CCC, jour des Récompenses    
Primidi 1 Vendémiaire CCCI, jour du Raisin          
Sextidi 6 jour compl. CCCVIII, jour de la Révolution
Primidi 1 Vendémiaire CCCIX, jour du Raisin         
Sextidi 6 jour compl. CD, jour de la Révolution     
Primidi 1 Vendémiaire CDI, jour du Raisin           
Quintidi 5 jour compl. CDI, jour des Récompenses    
Primidi 1 Vendémiaire CDVIII, jour du Raisin        
Sextidi 6 jour compl. CDVIII, jour de la Révolution 
Primidi 1 Vendémiaire M, jour du Raisin             
Primidi 1 Vendémiaire MI, jour du Raisin            
Duodi 12 Nivôse MCCVIII, jour de l'Argile           
Primidi 11 Nivôse MCCIX, jour du Granit             
Primidi 1 Vendémiaire MM, jour du Raisin            
Primidi 1 Vendémiaire MMI, jour du Raisin           
Duodi 12 Nivôse MMCCVIII, jour de l'Argile          
Duodi 12 Nivôse MMCCIX, jour de l'Argile            
Quartidi 24 Fructidor MMDXXVIII, jour du Sorgho     
Quintidi 25 Fructidor MMDXXVIII, jour de l'Écrevisse
Primidi 1 Vendémiaire MMM, jour du Raisin           
Primidi 1 Vendémiaire MMMI, jour du Raisin          
Duodi 12 Nivôse MMMCCVIII, jour de l'Argile         
Primidi 11 Nivôse MMMCCIX, jour du Granit           
Primidi 1 Vendémiaire 4000, jour du Raisin          
Primidi 1 Vendémiaire 4001, jour du Raisin          
Tridi 13 Nivôse 4208, jour de l'Ardoise             
Tridi 13 Nivôse 4209, jour de l'Ardoise             
Primidi 1 Vendémiaire 5000, jour du Raisin          
Primidi 1 Vendémiaire 5001, jour du Raisin          
Primidi 1 Vendémiaire 6000, jour du Raisin          
V-end
∇
∇ alltests
testfr2rd
testgr2rd
testrd2fr
testrd2gr
testgr2fr
testfr2gr
testprtfr
∇
∇ testfr2rd; IO; ⎕IO; OK; PARAM; EXPEC; RESUL
⎕IO ← 1
EXPEC ← testdata[;7]
PARAM ← testdata[;4 5 6]
OK ← 1
IO ← 2
LOOP:
IO ← IO - 1
⎕IO ← IO
OK ←OK ∧ test0fr2rd 1
OK ←OK ∧ test0fr2rd 2
OK ←OK ∧ test1fr2rd 1 ↑ ⍴PARAM ⍝ checking with the full vector
OK ←OK ∧ test1fr2rd 5 5
OK ←OK ∧ test1fr2rd 5 3 3
OK ←OK ∧ test1fr2rd 5 2 2 2
OK ←OK ∧ test1fr2rd 7 ⍴ 2 ⍝ checking max allowed rank
→ IO / LOOP
→ (OK=0) / 0 ⍝ exit if the errors are already reported
'Checking fr2rd : no errors'
∇
∇ R  ← test0fr2rd N; LIB; PAR; EXP; GOT; NERR
⎕IO ← 1
EXP ← EXPEC[N]
PAR ← PARAM[N;]
LIB  ← 'Checking fr2rd with scalar date ', (⍕PAR), ' and ⎕IO ', ⍕IO
⎕IO ← IO
GOT  ← fr2rd PAR
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDATA ⍝ no need to check dimension, it is the empty vector
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ R  ← test1fr2rd DIM; LIB; EXP; GOT; NERR
LIB  ← 'Checking fr2rd with dimension ', (⍕DIM), ' and ⎕IO ', ⍕IO
EXP ← DIM ⍴ EXPEC
⎕IO ← IO
GOT  ← fr2rd (DIM, 3) ⍴ PARAM
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimension: expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ testgr2rd; IO; ⎕IO; OK; PARAM; EXPEC; RESUL
⎕IO ← 1
EXPEC ← testdata[;7]
PARAM ← testdata[;1 2 3]
OK ← 1
IO ← 2
LOOP:
IO ← IO - 1
⎕IO ← IO
OK ←OK ∧ test0gr2rd 1
OK ←OK ∧ test0gr2rd 2
OK ←OK ∧ test1gr2rd 1 ↑ ⍴PARAM ⍝ checking with the full vector
OK ←OK ∧ test1gr2rd 5 5
OK ←OK ∧ test1gr2rd 5 3 3
OK ←OK ∧ test1gr2rd 5 2 2 2
OK ←OK ∧ test1gr2rd 7 ⍴ 2 ⍝ checking max allowed rank
→ IO / LOOP
→ (OK=0) / 0 ⍝ exit if the errors are already reported
'Checking gr2rd : no errors'
∇
∇ R  ← test0gr2rd N; LIB; PAR; EXP; GOT; NERR
⎕IO ← 1
EXP ← EXPEC[N]
PAR ← PARAM[N;]
LIB  ← 'Checking gr2rd with scalar date ', (⍕PAR), ' and ⎕IO ', ⍕IO
⎕IO ← IO
GOT  ← gr2rd PAR
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDATA ⍝ no need to check dimension, it is the empty vector
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ R  ← test1gr2rd DIM; LIB; EXP; GOT; NERR
LIB  ← 'Checking gr2rd with dimension ', (⍕DIM), ' and ⎕IO ', ⍕IO
EXP ← DIM ⍴ EXPEC
GOT ← gr2rd (DIM, 3) ⍴ PARAM
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ testrd2fr; IO; ⎕IO; OK; PARAM; EXPEC; RESUL
⎕IO ← 1
EXPEC ← testdata[;4 5 6]
PARAM ← testdata[;7]
OK ← 1
IO ← 2
LOOP:
IO ← IO - 1
⎕IO ← IO
OK ←OK ∧ test0rd2fr 1
OK ←OK ∧ test0rd2fr 2
OK ←OK ∧ test1rd2fr 1 ↑ ⍴PARAM ⍝ checking with the full vector
OK ←OK ∧ test1rd2fr 3 3
OK ←OK ∧ test1rd2fr 15 3
OK ←OK ∧ test1rd2fr 2 3 3
OK ←OK ∧ test1rd2fr 6 ⍴ 2 ⍝ checking max allowed rank
→ IO / LOOP
→ (OK=0) / 0 ⍝ exit if the errors are already reported
'Checking rd2fr : no errors'
∇
∇ R  ← test0rd2fr N; LIB; PAR; EXP; GOT; NERR
⎕IO ← 1
EXP ← EXPEC[N;]
PAR ← PARAM[N]
LIB  ← 'Checking rd2fr with scalar RD value ', (⍕PAR), ' and ⎕IO ', ⍕IO
⎕IO ← IO
GOT  ← rd2fr PAR
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimensions: expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ R ← test1rd2fr DIM; EXP; GOT; LIB; NERR
LIB  ← 'Checking rd2fr with dimension ', (⍕DIM), ' and ⎕IO ', ⍕IO
EXP ← (DIM, 3) ⍴ EXPEC
GOT ← rd2fr DIM ⍴ PARAM
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ testrd2gr; IO; ⎕IO; OK; PARAM; EXPEC; RESUL
⎕IO ← 1
EXPEC ← testdata[;1 2 3]
PARAM ← testdata[;7]
OK ← 1
IO ← 2
LOOP:
IO ← IO - 1
⎕IO ← IO
OK ←OK ∧ test0rd2gr 1
OK ←OK ∧ test0rd2gr 2
OK ←OK ∧ test1rd2gr 1 ↑ ⍴PARAM ⍝ checking with the full vector
OK ←OK ∧ test1rd2gr 3 3
OK ←OK ∧ test1rd2gr 15 3
OK ←OK ∧ test1rd2gr 2 3 3
→ IO / LOOP
→ (OK=0) / 0 ⍝ exit if the errors are already reported
'Checking rd2gr : no errors'
∇
∇ R  ← test0rd2gr N; LIB; PAR; EXP; GOT; NERR
⎕IO ← 1
EXP ← EXPEC[N;]
PAR ← PARAM[N]
LIB  ← 'Checking rd2gr with scalar RD value ', (⍕PAR), ' and ⎕IO ', ⍕IO
⎕IO ← IO
GOT  ← rd2gr PAR
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimensions: expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ R ← test1rd2gr DIM; EXP; GOT; LIB; NERR
LIB  ← 'Checking rd2gr with dimension ', (⍕DIM), ' and ⎕IO ', ⍕IO
EXP ← (DIM, 3) ⍴ EXPEC
GOT ← rd2gr DIM ⍴ PARAM
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ testgr2fr; IO; ⎕IO; OK; PARAM; EXPEC; RESUL
⎕IO ← 1
EXPEC ← testdata[;4 5 6]
PARAM ← testdata[;1 2 3]
OK ← 1
IO ← 2
LOOP:
IO ← IO - 1
⎕IO ← IO
OK ←OK ∧ test0gr2fr 1
OK ←OK ∧ test0gr2fr 2
OK ←OK ∧ test1gr2fr 1 ↑ ⍴PARAM ⍝ checking with the full vector
OK ←OK ∧ test1gr2fr 3 3
OK ←OK ∧ test1gr2fr 15 3
OK ←OK ∧ test1gr2fr 2 3 3
OK ←OK ∧ test1gr2fr 6 ⍴ 2 ⍝ checking max allowed rank
→ IO / LOOP
→ (OK=0) / 0 ⍝ exit if the errors are already reported
'Checking gr2fr : no errors'
∇
∇ R  ← test0gr2fr N; LIB; PAR; EXP; GOT; NERR
⎕IO ← 1
EXP ← EXPEC[N;]
PAR ← PARAM[N;]
LIB  ← 'Checking gr2fr with scalar RD value ', (⍕PAR), ' and ⎕IO ', ⍕IO
⎕IO ← IO
GOT  ← gr2fr PAR
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimensions: expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ R ← test1gr2fr DIM; EXP; GOT; LIB; NERR
LIB  ← 'Checking gr2fr with dimension ', (⍕DIM), ' and ⎕IO ', ⍕IO
EXP ← (DIM, 3) ⍴ EXPEC
GOT ← gr2fr (DIM, 3) ⍴ PARAM
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ testfr2gr; IO; ⎕IO; OK; PARAM; EXPEC; RESUL
⎕IO ← 1
EXPEC ← testdata[;1 2 3]
PARAM ← testdata[;4 5 6]
OK ← 1
IO ← 2
LOOP:
IO ← IO - 1
⎕IO ← IO
OK ←OK ∧ test0fr2gr 1
OK ←OK ∧ test0fr2gr 2
OK ←OK ∧ test1fr2gr 1 ↑ ⍴PARAM ⍝ checking with the full vector
OK ←OK ∧ test1fr2gr 3 3
OK ←OK ∧ test1fr2gr 15 3
OK ←OK ∧ test1fr2gr 2 3 3
OK ←OK ∧ test1fr2gr 6 ⍴ 2 ⍝ checking max allowed rank
→ IO / LOOP
→ (OK=0) / 0 ⍝ exit if the errors are already reported
'Checking fr2gr : no errors'
∇
∇ R  ← test0fr2gr N; LIB; PAR; EXP; GOT; NERR
⎕IO ← 1
EXP ← EXPEC[N;]
PAR ← PARAM[N;]
LIB  ← 'Checking fr2gr with scalar RD value ', (⍕PAR), ' and ⎕IO ', ⍕IO
⎕IO ← IO
GOT  ← fr2gr PAR
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank: expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimensions: expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ R ← test1fr2gr DIM; EXP; GOT; LIB; NERR
LIB  ← 'Checking fr2gr with dimension ', (⍕DIM), ' and ⎕IO ', ⍕IO
EXP ← (DIM, 3) ⍴ EXPEC
GOT ← fr2gr (DIM, 3) ⍴ PARAM
→ ((⍴⍴EXP)=⍴⍴GOT)/CHKDIM
LIB, ' Wrong rank, expected ', (⍕⍴⍴EXP), ', got ', ⍕⍴⍴GOT
R ← 0
→ 0
CHKDIM:
→ (∧/(⍴EXP)=⍴GOT)/CHKDATA
LIB, ' Wrong dimension, expected ', (⍕⍴EXP), ', got ', ⍕⍴GOT
R ← 0
→ 0
CHKDATA:
NERR ← +/,∨/EXP≠GOT
→ (NERR=0) / CHKIO
LIB, ' Data errors: ', ⍕ NERR
R ← 0
→ 0
CHKIO:
→ (IO=⎕IO) / SUCCESS
LIB, ' ⎕IO clobbered: was ', (⍕IO), ' became ', ⍕⎕IO
R ← 0
→ 0
SUCCESS:
R ← 1
→ 0
∇
∇ testprtfr; TD; TS; I; IMAX; PAR; EXP; GOT; N; IO; ⎕IO
IO ← 2
LOOPIO:
IO ← IO - 1
'Checking prtfr with the full vector (a bit slow) and ⎕IO ', ⍕IO
⎕IO ← 1
TD ← testdata[; 4 5 6 ]
TS ← teststring
I ← 0
N ← 0
IMAX ← (⍴ TS)[1]
LOOP:
⎕IO ← 1
I ← I + 1
→ (I > IMAX)/END
PAR ← TD[I;]
EXP ← TS[I;]
EXP ← (⌽∨\⌽EXP≠' ')/EXP
⎕IO ← IO
GOT ← prtfr PAR
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
'Data errors with ⎕IO = ', (⍕IO), ' : ', ⍕N
→ IO / LOOPIO 
∇
