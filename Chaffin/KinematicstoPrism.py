import os
import glob
import openpyxl
import pandas as pd
from pathlib import Path

if __name__ == '__main__':

    counter = 0

    path = os.path.join(
        Path('C:/Users/Usuario/OneDrive - uv.cl/LabErgonomía/ProyectosTesis/Escritorio/Data/DataModel/*xlsx'))

    files = glob.glob(path)

    conditionOne = []
    conditionTwo = []

    targetModelOutput1 = "Abduction"
    targetModelOutput2 = "Flexion"

    targetModelMeasurement1 = "Amplitude"
    targetModelMeasurement2 = "Duration"
    targetModelMeasurement3 = "Vel_mean"
    targetModelMeasurement4 = "Mean"

    targetModelOutput = targetModelOutput1
    targetModelMeasurement = targetModelMeasurement2

    for f in files:

        dataFrame = pd.read_excel(f)

        headers = dataFrame.columns.values

        start = 0
        end = 1
        header = headers[0]
        C1 = []
        C2 = []

        if targetModelOutput == "Abduction":
            start = [0, 6]
            end = [6, 12]
        elif targetModelOutput == "Flexion":
            start = [12, 18]
            end = [18, 24]

        if targetModelMeasurement == "Amplitude":
            header = headers[1]
        elif targetModelMeasurement == "Duration":
            header = headers[2]
        elif targetModelMeasurement == "Vel_mean":
            header = headers[3]
        elif targetModelMeasurement == "Mean":
            header = headers[6]

        for i in range(start[0], end[0]):
            temp1 = dataFrame[header][i]
            C1.append(temp1)
        conditionOne.append(C1)

        for i in range(start[1], end[1]):
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
