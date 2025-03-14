clear all
tempfile forgalom
save `forgalom', emptyok replace

local YEARS 2024 2025
foreach t in `YEARS' {
    import delimited using "output/gyogyszer/`t'.csv", clear
    append using `forgalom'
    save `forgalom', replace
}
generate tb_tamogatas = tbtam  + kvater
rename fogyar teljes_ar
generate teritesi_dij = terdij 
rename doboz mennyiseg

* aggregate over venytipus, but not jogcim
collapse (sum) mennyiseg teljes_ar teritesi_dij tb_tamogatas, by(ttt nev tk idoszak jogcim)
foreach X in teljes_ar teritesi_dij tb_tamogatas {
    replace `X' = `X' / mennyiseg
}
export delimited "output/gyogyszer.csv", replace
