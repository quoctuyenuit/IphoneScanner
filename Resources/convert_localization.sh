python3 parse_localization.py -i ./localizations.csv
cp output/localizationsKeys.swift ../IMEIScanner/Languages/LocalizationKeys.swift
cp output/localizations_en.strings ../IMEIScanner/Base.lproj/Localizable.strings
cp output/localizations_vi.strings ../IMEIScanner/vi.lproj/Localizable.strings
cp output/localizations_en.strings ../IMEIScanner/en.lproj/Localizable.strings
