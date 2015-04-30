∇ license
'APL program to convert Gregorian dates'
'to French Revolutionary dates and the other way'
'Copyright (C) 2015 Jean Forget'
''
' This program is distributed under the same terms as Perl 5.16.3:'
' GNU Public License version 1 or later and Perl Artistic License'
''
' You can find the text of the licenses in the F<LICENSE> file or at'
' L<http://www.perlfoundation.org/artistic_license_1_0>'
' and L<http://www.gnu.org/licenses/gpl-1.0.html>.'
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
∇ testfr2rd
'Erreurs: ', ⍕ +/ testdata[;7] ≠ fr2rd testdata[;4 5 6]
test1fr2rd 5 5
test1fr2rd 5 3 3
test1fr2rd 5 2 2 2
∇
∇ test1fr2rd DIM
'Checking with dimension ', ⍕ DIM
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
'Data errors: ', ⍕ +/,∨/EXP≠GOT
∇
∇ testgr2rd
'Erreurs: ', ⍕ +/ testdata[;7] ≠ gr2rd testdata[;1 2 3]
test1gr2rd 5 5
test1gr2rd 5 3 3
test1gr2rd 5 2 2 2
∇
∇ test1gr2rd DIM
'Checking with dimension ', ⍕ DIM
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
'Data errors: ', ⍕ +/,∨/EXP≠GOT
∇
∇ testrd2fr
'Checking the full vector: errors: ', ⍕ +/∨/ testdata[;4 5 6] ≠ rd2fr testdata[;7]
test1rd2fr 3 3
test1rd2fr 15 3
test1rd2fr 2 3 3
∇
∇ test1rd2fr DIM
'Checking with dimension ', ⍕ DIM
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
