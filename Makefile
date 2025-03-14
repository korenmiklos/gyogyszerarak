all: output/2024.csv output/2025.csv REKORDLEIRAS.xls
output/%.csv: temp/NEAK_GYSZ_Forg_%01.mdb
	mdb-export $< ORSZAGOS_FORGALOM > $@
temp/%.mdb: temp/%.zip
	unzip -d temp $<
temp/NEAK_GYSZ_Forg_202401.zip: 
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/gyogyszer/forg/2024-forg-adat/NEAK_GYSZ_Forg_202401.zip1&inline=true" -o $@
temp/NEAK_GYSZ_Forg_202501.zip:
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/gyogyszer/forg/2025-forg-adat/NEAK_GYSZ_Forg_202501.zip1&inline=true" -o $@
REKORDLEIRAS.xls:
	curl "https://neak.gov.hu/pfile/file?path=/letoltheto/ATFO_dok/gyogyszer/forg/REKORDLEIRAS&inline=true" -o $@