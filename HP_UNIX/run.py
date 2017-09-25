#!/usr/bin/env python3
import openpyxl
from xml.etree.ElementTree import parse

doc = parse('result.xml')

l = list()
for i in doc.iter('item'):
    l += [[i.get('flag'),str(i.find('command').text),str(i.find('value').text)]]
wb = openpyxl.Workbook()
ws = wb.active
for i in range(1,len(l)+1):
    for j in range(1,4):
        ws.cell(row=i,column=j,value=l[i-1][j-1])
wb.save('result.xlsx')
print('已生成excel文件')


