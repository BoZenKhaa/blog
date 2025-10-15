# Tips for processing Google Sheet data to prepare "prispevky"

Export members into "prispevky" sheet, and fee payments into "registrace" sheet.

## Google Sheets functions

Get `surname name` from `surname (nickname)`:

 - `=REGEXREPLACE(A2; "( \(.*\))";"")`
 - Apply to data in "registrace"

Get payment values from "registrace" into "prispevky", linking through "name surname":

 -  `=VLOOKUP(C3;Registrace2024!B:K;7;0)`

Detect duplicate names in "prispevky" with conditional formatting:

 - `=COUNTIF($C$2:$C$987;C2)>1`
 - Apply to data in "prispevky"

OR use sheets function Data -> Data cleanup -> Remove Duplicates

## Process for "upominky"

1. Do an export from skautis, save it as an export in [sheets](https://docs.google.com/spreadsheets/d/1cCLFMvATZGM79NIq3ApinJZ4qEj-KoR8lKe6m_Z8Ao0/edit?gid=1173841731#gid=1173841731)
2. Remove duplicates via `Data > Data clean-up > Remove duplicates`
3. Remove empty columns, this will fail the import.
3. Join name and surname with `=A2&" "&B2`
4. Vlookup value to pay via e.g. `=VLOOKUP(C:C;UpominkyPodzim2024!A:L; 9;false)`
5. If the value is not a number, use "Find and replace" to remove the "Kč" and spaces.
6. Verify all the values are looked up correctly. For example, count whether the number of values matches between the two sheets.