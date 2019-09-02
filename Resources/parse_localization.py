import argparse
from pathlib import Path
import numpy as np

class LocalizationParser:
    def __init__(self, path):
        self.fileName = Path(path).stem

        self.localizations = self.read_csv(path)
        self.languages = self.localizations[0][2:]
        self.localizations = np.array(self.localizations[1:]).T

    def read_csv(self, path):
        return [line[:-1].split(',') for line in open(path, 'r', encoding='utf8') if len(line.split(',')[-1]) > 1]
        

    def write_data(self, path):
        with open(path, 'w', encoding='utf8') as file:
            name = Path(path).stem
            file.write('//\n//{}\n//IMEIScanner\n//\n//enum is generated from scrip, do not change any in this file.\n//created by tuyennq\n\n'.format(name))
            file.write('import Foundation\n\nenum {}'.format(name))
            file.write(' {\n')

            for key in self.localizations[1]:
                file.write('\tcase {}\n'.format(key))

            for index in range(len(self.languages)):
                keys = self.localizations[1]
                messages = self.localizations[index + 2]
                lang = self.languages[index]
                
                file.write('\n\tvar {}Msg: String '.format(lang))
                file.write('{\n\t\tswitch self {\n')
                
                for keyIndex in range(len(keys)):
                    key = keys[keyIndex]
                    msg = messages[keyIndex]
                    file.write('\t\tcase .{}:\n\t\t\treturn \"{}\"\n'.format(key, msg))
                
                file.write('\t\t}\n\t}\n')

            file.write('}')


        for index in range(len(self.languages)):
            path = self.fileName + '_' + self.languages[index] + ".strings"
            self.__write_swift_file__(path, np.array([self.localizations[1], self.localizations[index + 2]]).T)
            
            
    def __write_swift_file__(self, path, datas):
        with open(path, 'w', encoding='utf8') as file:
            name = Path(path).stem
            file.write('//\n//{}\n//IMEIScanner\n//\n//struct is generated from scrip, do not change any in this file.\n//created by tuyennq\n\n'.format(name))
            file.write('import Foundation\n\nclass {}'.format(name))
            file.write(' {\n')
            for data in datas:
                key = data[0]
                msg = data[1]
                file.write('\tstatic let {}: String = \"{}\"\n'.format(key, msg))
            file.write('}')
        


parser = argparse.ArgumentParser()
parser.add_argument('-i', dest='input_path', help="Nhập đường dẫn file csv localizations", type=str)
parser.add_argument('-o', dest='output_path', help="Nhập đường dẫn file cần parse (swift file)", type=str)
args = parser.parse_args()

localizationParser = LocalizationParser(args.input_path)
localizationParser.write_data(args.output_path)