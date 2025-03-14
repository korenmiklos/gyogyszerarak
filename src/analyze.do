clear
import delimited "output/gyogyszerarak.csv", clear

generate ev = int(idoszak/100)

local FACTS mennyiseg tb_tamogatas teritesi_dij teljes_ar
local DIMS gyogyszer_id ev
local FUNCTIONAL nev gyogyszer torzskonyvi_szam 

tabulate jogcim
* drop Kozgyogy and egyedi arak
keep if inlist(jogcim, "Normatív", "Emelt", "Kiemelt")
* merge Emelt and Kiemelt
replace jogcim = "Emelt" if jogcim == "Kiemelt"
foreach X in mennyiseg tb_tamogatas teritesi_dij teljes_ar {
    drop if `X' < 0
}
foreach X in tb_tamogatas teritesi_dij teljes_ar {
    replace `X' = `X' * mennyiseg
}
collapse (sum) `FACTS', by(`DIMS' `FUNCTIONAL' jogcim)
foreach X in tb_tamogatas teritesi_dij teljes_ar {
    replace `X' = `X' / mennyiseg
}
replace jogcim = substr(jogcim, 1, 1)
reshape wide `FACTS', i(`DIMS') j(jogcim) string
reshape long
mvencode `FACTS', mv(0) override
reshape wide
sort `DIMS'
order `DIMS' `FUNCTIONAL'

generate byte emelt = tb_tamogatasE > 0 & !missing(tb_tamogatasE)
generate atlagar = (teritesi_dijE * mennyisegE + teritesi_dijN * mennyisegN)/(mennyisegE + mennyisegN) if (mennyisegE+mennyisegN) >= 5

xtset gyogyszer_id ev
generate inflacio = F.atlagar / atlagar * 100 - 100
generate osszeg = int(teritesi_dijE * mennyisegE + teritesi_dijN * mennyisegN)
