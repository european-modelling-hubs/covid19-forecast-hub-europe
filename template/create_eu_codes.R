# Get EU + UK country names + codes

eu28 <- countrycode::codelist

eu28 <- eu28[!is.na(eu28$eu28),]

eu28 <- dplyr::select(eu28, 
                      eu28, continent, iso.name.en, iso2c, 
                      country.name.en.regex, eurostat, fao, fips,  iso3c)

readr::write_csv(eu28, "locations_eu.csv")