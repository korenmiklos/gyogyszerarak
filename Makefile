TABLAK := gyogyszer gyse
EVEK := 2024 2025

all: $(foreach tabla,$(TABLAK),output/$(tabla)/REKORDLEIRAS.xls output/$(tabla).csv)
output/%.csv: %.do $(foreach ev,$(EVEK),output/%/$(ev).csv)
	stata -b do $<
output/gyse/%.csv: temp/%01.mdb
	mkdir -p $(dir $@)
	mdb-export $< ORSZAGOS_FORGALOM > $@
output/gyogyszer/%.csv: temp/NEAK_GYSZ_Forg_%01.mdb
	mkdir -p $(dir $@)
	mdb-export $< ORSZAGOS_FORGALOM > $@
temp/%.mdb: temp/%.zip
	unzip -d temp $<
temp/NEAK_GYSZ_Forg_202401.zip: 
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/gyogyszer/forg/2024-forg-adat/NEAK_GYSZ_Forg_202401.zip1&inline=true" -o $@
temp/NEAK_GYSZ_Forg_202501.zip:
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/gyogyszer/forg/2025-forg-adat/NEAK_GYSZ_Forg_202501.zip1&inline=true" -o $@
output/gyogyszer/REKORDLEIRAS.xls:
	mkdir -p $(dir $@)
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/gyogyszer/forg/REKORDLEIRAS&inline=true" -o $@
output/gyse/REKORDLEIRAS.xls:
	mkdir -p $(dir $@)
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/GYSE/gyse_forg/Adatmezok-leirasa&inline=true" -o $@
temp/NEAK_GYSE_Forg_202401.zip:
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/GYSE/gyse_forg/2024-es-forgalmi-adatok/202401.zip1&inline=true" -o $@
temp/NEAK_GYSE_Forg_202501.zip:
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/GYSE/gyse_forg/2025-os-forgalmi-adatok/202501.zip1&inline=true" -o $@
