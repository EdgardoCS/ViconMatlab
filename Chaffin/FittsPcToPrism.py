# Created by "EdgardoCS"
__github__ = "https://github.com/EdgardoCS"
__email__ = "edgardo.silva@uv.cl"

import os
import glob
import pandas as pd
from pathlib import Path

if __name__ == '__main__':
    counter = 0

    path = os.path.join(
        Path('C:/Users/Usuario/OneDrive - uv.cl/LabErgonomía/ProyectosTesis/Pregrado_Kine_Escritorio/Data/*csv'))

    files = glob.glob(path)
    print(files)

    targetFile = files[0]

    dataFrame = pd.read_csv(targetFile)
    headers = dataFrame.columns.values

    start = [0, 9]
    end = [9, 18]
    diff = 18

    targetHeader = [headers[21], headers[20]]

    for target in targetHeader:
        conditionOne = []
        conditionTwo = []
        for j in range(0, 34):
            C1 = []
            C2 = []
            for i in range(start[0] + (diff * j), end[0] + (diff * j)):
                temp1 = dataFrame[target][i]
                C1.append(temp1)
            conditionOne.append(C1)
            for i in range(start[1] + (diff * j), end[1] + (diff * j)):
                temp2 = dataFrame[target][i]
                C2.append(temp2)
            conditionTwo.append(C2)

        dfOne = pd.DataFrame(conditionOne)
        dfOne = dfOne.transpose()
        dfTwo = pd.DataFrame(conditionTwo)
        dfTwo = dfTwo.transpose()

        outputFile = 'Pc_' + target + '.xlsx'
        print(outputFile)

        with pd.ExcelWriter(outputFile) as writer:
            dfOne.to_excel(writer, sheet_name='Condition1', index=False, header=False)
            dfTwo.to_excel(writer, sheet_name='Condition2', index=False, header=False)
