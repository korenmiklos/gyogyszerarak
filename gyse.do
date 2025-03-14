clear all
tempfile forgalom
save `forgalom', emptyok replace

local YEARS 2024 2025
foreach t in `YEARS' {
    import delimited using "output/gyse/`t'.csv", clear
    append using `forgalom'
    save `forgalom', replace
}
rename tbtam tb_tamogatas
rename oep_nev nev
generate teritesi_dij = betegft

* aggregate over venytipus, but not jogcim
collapse (sum) mennyiseg teritesi_dij tb_tamogatas, by(ttt nev idoszak jogcim)
foreach X in teritesi_dij tb_tamogatas {
    replace `X' = `X' / mennyiseg
}
export delimited "output/gyse.csv", replace
