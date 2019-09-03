import argparse
from pathlib import Path
import numpy as np
import os

class LocalizationParser:
    def __init__(self, path):
        self.fileName = Path(path).stem

        self.localizations = self.read_csv(path)
        self.languages = self.localizations[0][2:]
        self.localizations = np.array(self.localizations[1:]).T

    def read_csv(self, path):
        return [line[:-1].split(',') for line in open(path, 'r', encoding='utf8') if len(line.split(',')[-1]) > 1]
        

    def write_data(self, path):
        out_path = os.path.join(path, self.fileName)
        key_path = out_path + "Keys.swift"

        #========================================================================
        #Generate keys file
        #========================================================================
        with open(key_path, 'w', encoding='utf8') as file:
            name = "LocalizationKeys"
            file.write('//\n//{}\n//IMEIScanner\n//\n//enum is generated from scrip, do not change any in this file.\n//created by tuyennq\n\n'.format(name))
            file.write('import Foundation\n\n')
            file.write('enum Languages: String, CaseIterable {\n')
            for lang in self.languages:
                file.write('\tcase {} = \"{}\"\n'.format(lang, lang))
            file.write('}\n\n')

            file.write('enum {}: String'.format(name))
            file.write(' {\n')

            for key in self.localizations[1]:
                file.write('\tcase {} = \"{}\"\n'.format(key, key))

            file.write('}')
        
        #========================================================================
        #Generate strings file
        #========================================================================
        for index in range(len(self.languages)):
            lang = self.languages[index]
            keys = self.localizations[1]
            msgs = self.localizations[index + 2]
            strings_path = out_path + "_" + lang + ".strings"
            with open(strings_path, 'w', encoding = 'utf8') as file:
                file.write("/*\n Localizable.strings\n IMEIScanner\n\n Created by QuocTuyen\n Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.\n\n This file is generated by script, do not change any thing\n*/\n\n")
                for i in range(len(keys)):
                    key = keys[i]
                    msg = msgs[i]
                    file.write('\"{}\"=\"{}\";\n'.format(key, msg))




parser = argparse.ArgumentParser()
parser.add_argument('-i', dest='input_path', help="Nhập đường dẫn file csv localizations", type=str)
parser.add_argument('-o', dest='output_path', default='./', help="Nhập đường dẫn file cần parse (swift file)", type=str)
args = parser.parse_args()

output_path = os.path.join(args.output_path, "output")
try:
    os.makedirs(output_path)
except:
    print('exists file output')

localizationParser = LocalizationParser(args.input_path)
localizationParser.write_data(output_path)