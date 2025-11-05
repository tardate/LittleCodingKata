valid([]).
valid([Head|Tail]) :- fd_all_different(Head), valid(Tail).

sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
  Puzzle = [
    S00, S01, S02, S03, S04, S05, S06, S07, S08, S09, S0A, S0B, S0C, S0D, S0E, S0F,
    S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S1A, S1B, S1C, S1D, S1E, S1F,
    S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, S2A, S2B, S2C, S2D, S2E, S2F,
    S30, S31, S32, S33, S34, S35, S36, S37, S38, S39, S3A, S3B, S3C, S3D, S3E, S3F,
    S40, S41, S42, S43, S44, S45, S46, S47, S48, S49, S4A, S4B, S4C, S4D, S4E, S4F,
    S50, S51, S52, S53, S54, S55, S56, S57, S58, S59, S5A, S5B, S5C, S5D, S5E, S5F,
    S60, S61, S62, S63, S64, S65, S66, S67, S68, S69, S6A, S6B, S6C, S6D, S6E, S6F,
    S70, S71, S72, S73, S74, S75, S76, S77, S78, S79, S7A, S7B, S7C, S7D, S7E, S7F,
    S80, S81, S82, S83, S84, S85, S86, S87, S88, S89, S8A, S8B, S8C, S8D, S8E, S8F,
    S90, S91, S92, S93, S94, S95, S96, S97, S98, S99, S9A, S9B, S9C, S9D, S9E, S9F,
    SA0, SA1, SA2, SA3, SA4, SA5, SA6, SA7, SA8, SA9, SAA, SAB, SAC, SAD, SAE, SAF,
    SB0, SB1, SB2, SB3, SB4, SB5, SB6, SB7, SB8, SB9, SBA, SBB, SBC, SBD, SBE, SBF,
    SC0, SC1, SC2, SC3, SC4, SC5, SC6, SC7, SC8, SC9, SCA, SCB, SCC, SCD, SCE, SCF,
    SD0, SD1, SD2, SD3, SD4, SD5, SD6, SD7, SD8, SD9, SDA, SDB, SDC, SDD, SDE, SDF,
    SE0, SE1, SE2, SE3, SE4, SE5, SE6, SE7, SE8, SE9, SEA, SEB, SEC, SED, SEE, SEF,
    SF0, SF1, SF2, SF3, SF4, SF5, SF6, SF7, SF8, SF9, SFA, SFB, SFC, SFD, SFE, SFF
  ],

  fd_domain(Puzzle, 0, 15),

  Row0 = [S00, S01, S02, S03, S04, S05, S06, S07, S08, S09, S0A, S0B, S0C, S0D, S0E, S0F],
  Row1 = [S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S1A, S1B, S1C, S1D, S1E, S1F],
  Row2 = [S20, S21, S22, S23, S24, S25, S26, S27, S28, S29, S2A, S2B, S2C, S2D, S2E, S2F],
  Row3 = [S30, S31, S32, S33, S34, S35, S36, S37, S38, S39, S3A, S3B, S3C, S3D, S3E, S3F],
  Row4 = [S40, S41, S42, S43, S44, S45, S46, S47, S48, S49, S4A, S4B, S4C, S4D, S4E, S4F],
  Row5 = [S50, S51, S52, S53, S54, S55, S56, S57, S58, S59, S5A, S5B, S5C, S5D, S5E, S5F],
  Row6 = [S60, S61, S62, S63, S64, S65, S66, S67, S68, S69, S6A, S6B, S6C, S6D, S6E, S6F],
  Row7 = [S70, S71, S72, S73, S74, S75, S76, S77, S78, S79, S7A, S7B, S7C, S7D, S7E, S7F],
  Row8 = [S80, S81, S82, S83, S84, S85, S86, S87, S88, S89, S8A, S8B, S8C, S8D, S8E, S8F],
  Row9 = [S90, S91, S92, S93, S94, S95, S96, S97, S98, S99, S9A, S9B, S9C, S9D, S9E, S9F],
  RowA = [SA0, SA1, SA2, SA3, SA4, SA5, SA6, SA7, SA8, SA9, SAA, SAB, SAC, SAD, SAE, SAF],
  RowB = [SB0, SB1, SB2, SB3, SB4, SB5, SB6, SB7, SB8, SB9, SBA, SBB, SBC, SBD, SBE, SBF],
  RowC = [SC0, SC1, SC2, SC3, SC4, SC5, SC6, SC7, SC8, SC9, SCA, SCB, SCC, SCD, SCE, SCF],
  RowD = [SD0, SD1, SD2, SD3, SD4, SD5, SD6, SD7, SD8, SD9, SDA, SDB, SDC, SDD, SDE, SDF],
  RowE = [SE0, SE1, SE2, SE3, SE4, SE5, SE6, SE7, SE8, SE9, SEA, SEB, SEC, SED, SEE, SEF],
  RowF = [SF0, SF1, SF2, SF3, SF4, SF5, SF6, SF7, SF8, SF9, SFA, SFB, SFC, SFD, SFE, SFF],

  Col0 = [S00, S10, S20, S30, S40, S50, S60, S70, S80, S90, SA0, SB0, SC0, SD0, SE0, SF0],
  Col1 = [S01, S11, S21, S31, S41, S51, S61, S71, S81, S91, SA1, SB1, SC1, SD1, SE1, SF1],
  Col2 = [S02, S12, S22, S32, S42, S52, S62, S72, S82, S92, SA2, SB2, SC2, SD2, SE2, SF2],
  Col3 = [S03, S13, S23, S33, S43, S53, S63, S73, S83, S93, SA3, SB3, SC3, SD3, SE3, SF3],
  Col4 = [S04, S14, S24, S34, S44, S54, S64, S74, S84, S94, SA4, SB4, SC4, SD4, SE4, SF4],
  Col5 = [S05, S15, S25, S35, S45, S55, S65, S75, S85, S95, SA5, SB5, SC5, SD5, SE5, SF5],
  Col6 = [S06, S16, S26, S36, S46, S56, S66, S76, S86, S96, SA6, SB6, SC6, SD6, SE6, SF6],
  Col7 = [S07, S17, S27, S37, S47, S57, S67, S77, S87, S97, SA7, SB7, SC7, SD7, SE7, SF7],
  Col8 = [S08, S18, S28, S38, S48, S58, S68, S78, S88, S98, SA8, SB8, SC8, SD8, SE8, SF8],
  Col9 = [S09, S19, S29, S39, S49, S59, S69, S79, S89, S99, SA9, SB9, SC9, SD9, SE9, SF9],
  ColA = [S0A, S1A, S2A, S3A, S4A, S5A, S6A, S7A, S8A, S9A, SAA, SBA, SCA, SDA, SEA, SFA],
  ColB = [S0B, S1B, S2B, S3B, S4B, S5B, S6B, S7B, S8B, S9B, SAB, SBB, SCB, SDB, SEB, SFB],
  ColC = [S0C, S1C, S2C, S3C, S4C, S5C, S6C, S7C, S8C, S9C, SAC, SBC, SCC, SDC, SEC, SFC],
  ColD = [S0D, S1D, S2D, S3D, S4D, S5D, S6D, S7D, S8D, S9D, SAD, SBD, SCD, SDD, SED, SFD],
  ColE = [S0E, S1E, S2E, S3E, S4E, S5E, S6E, S7E, S8E, S9E, SAE, SBE, SCE, SDE, SEE, SFE],
  ColF = [S0F, S1F, S2F, S3F, S4F, S5F, S6F, S7F, S8F, S9F, SAF, SBF, SCF, SDF, SEF, SFF],

  Square0 = [S00, S01, S02, S03, S10, S11, S12, S13, S20, S21, S22, S23, S30, S31, S32, S33],
  Square1 = [S40, S41, S42, S43, S50, S51, S52, S53, S60, S61, S62, S63, S70, S71, S72, S73],
  Square2 = [S80, S81, S82, S83, S90, S91, S92, S93, SA0, SA1, SA2, SA3, SB0, SB1, SB2, SB3],
  Square3 = [SC0, SC1, SC2, SC3, SD0, SD1, SD2, SD3, SE0, SE1, SE2, SE3, SF0, SF1, SF2, SF3],
  Square4 = [S04, S05, S06, S07, S14, S15, S16, S17, S24, S25, S26, S27, S34, S35, S36, S37],
  Square5 = [S44, S45, S46, S47, S54, S55, S56, S57, S64, S65, S66, S67, S74, S75, S76, S77],
  Square6 = [S84, S85, S86, S87, S94, S95, S96, S97, SA4, SA5, SA6, SA7, SB4, SB5, SB6, SB7],
  Square7 = [SC4, SC5, SC6, SC7, SD4, SD5, SD6, SD7, SE4, SE5, SE6, SE7, SF4, SF5, SF6, SF7],
  Square8 = [S08, S09, S0A, S0B, S18, S19, S1A, S1B, S28, S29, S2A, S2B, S38, S39, S3A, S3B],
  Square9 = [S48, S49, S4A, S4B, S58, S59, S5A, S5B, S68, S69, S6A, S6B, S78, S79, S7A, S7B],
  SquareA = [S88, S89, S8A, S8B, S98, S99, S9A, S9B, SA8, SA9, SAA, SAB, SB8, SB9, SBA, SBB],
  SquareB = [SC8, SC9, SCA, SCB, SD8, SD9, SDA, SDB, SE8, SE9, SEA, SEB, SF8, SF9, SFA, SFB],
  SquareC = [S0C, S0D, S0E, S0F, S1C, S1D, S1E, S1F, S2C, S2D, S2E, S2F, S3C, S3D, S3E, S3F],
  SquareD = [S4C, S4D, S4E, S4F, S5C, S5D, S5E, S5F, S6C, S6D, S6E, S6F, S7C, S7D, S7E, S7F],
  SquareE = [S8C, S8D, S8E, S8F, S9C, S9D, S9E, S9F, SAC, SAD, SAE, SAF, SBC, SBD, SBE, SBF],
  SquareF = [SCC, SCD, SCE, SCF, SDC, SDD, SDE, SDF, SEC, SED, SEE, SEF, SFC, SFD, SFE, SFF],


  valid([Row0, Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9, RowA, RowB, RowC, RowD, RowE, RowF]),
  valid([Col0, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9, ColA, ColB, ColC, ColD, ColE, ColF]),
  valid([
    Square0, Square1, Square2, Square3,
    Square4, Square5, Square6, Square7,
    Square8, Square9, SquareA, SquareB,
    SquareC, SquareD, SquareE, SquareF
  ]).

safe_format_or_write(Value) :- (
  integer(Value) -> format('~16R', [Value]);
  write(Value)
).

print_sudoku(List) :-
  length(List, 256),
  print_rows(List, 0).
print_rows([], _).
print_rows([Head|Tail], Count) :-
  write('    '),
  safe_format_or_write(Head),
  (Count mod 16 =:= 15 -> nl ; tab(3)),
  NewCount is Count + 1,
  print_rows(Tail, NewCount).

solve_and_print(Sudoku) :-
  sudoku(Sudoku, Solution),
  print_sudoku(Solution).
