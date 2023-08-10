import os
import glob
import openpyxl
import pandas as pd
from pathlib import Path

if __name__ == '__main__':

    counter = 0

    path = os.path.join(
        Path('C:/Users/Usuario/OneDrive - uv.cl/LabErgonomía/ProyectosTesis/Escritorio/Data/DataEMG/'))
    textSeparator = ''

    targetEMGOutput1 = "DeltoideAnterior"
    targetEMGOutput2 = "DeltoideMedio"
    targetEMGOutput3 = "TrapecioSuperior"
    targetEMGOutput4 = "TrapecioMedio"
    targetEMGOutput5 = "TrapecioInferior"
    targetEMGOutput6 = "SerratoAnterior"

    targetEMGMeasurement1 = "%EMG"
    targetEMGMeasurement2 = "mVEMG"
    targetEMGMeasurement3 = "ON"

    EmgOutput = [targetEMGOutput1, targetEMGOutput2, targetEMGOutput3, targetEMGOutput4, targetEMGOutput5,
                 targetEMGOutput6]
    EmgMeasurements = [targetEMGMeasurement1, targetEMGMeasurement2, targetEMGMeasurement3]

    for n_muscles, a in enumerate(EmgOutput):
        for b in EmgMeasurements:
            conditionOne = []
            conditionTwo = []

            targetModelOutput = a
            targetModelMeasurement = b

            for count, x in enumerate(os.walk(path)):
                if count != 0 and count <= 20:
                    targetFolder = str(x[0].split('\\')[9])
                    targetFile = str(x[2][1])
                    newPath = ['C:/Users/Usuario/OneDrive - uv.cl/LabErgonomía/ProyectosTesis/Escritorio/Data/DataEMG/',
                               targetFolder, '/', targetFile]

                    dataFrame = pd.read_excel(textSeparator.join(newPath))

                    headers = dataFrame.columns.values

                    header = headers[0]
                    start = [0 + n_muscles, 36 + n_muscles]
                    end = [31 + n_muscles, 67 + n_muscles]
                    C1 = []
                    C2 = []

                    if targetModelMeasurement == "%EMG":
                        header = headers[1]
                    elif targetModelMeasurement == "mVEMG":
                        header = headers[4]
                    elif targetModelMeasurement == "ON":
                        header = headers[5]

                    for i in range(start[0], end[0], 6):
                        temp1 = dataFrame[header][i]
                        C1.append(temp1)
                    conditionOne.append(C1)

                    for i in range(start[1], end[1], 6):
                        temp2 = dataFrame[header][i]
                        C2.append(temp2)
                    conditionTwo.append(C2)

            # print(conditionOne)
            # print(conditionTwo)
            dfOne = pd.DataFrame(conditionOne)
            dfOne = dfOne.transpose()
            dfTwo = pd.DataFrame(conditionTwo)
            dfTwo = dfTwo.transpose()

            outputFile = targetModelOutput + targetModelMeasurement + '.xlsx'
            print(outputFile)

            with pd.ExcelWriter(outputFile) as writer:
                dfOne.to_excel(writer, sheet_name='Condition1', index=False, header=False)
                dfTwo.to_excel(writer, sheet_name='Condition2', index=False, header=False)
