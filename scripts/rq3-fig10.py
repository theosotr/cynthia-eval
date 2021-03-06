#! /usr/bin/env python3
from collections import defaultdict, OrderedDict
import sys

import seaborn as sns
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np


data = defaultdict(list)
with open(sys.argv[1]) as f:
    for line in f:
        line = line.strip()
        _, s, t = line.split(",")
        data[s].append(float(t))


def avg(data, key):
    return round((sum(data[key]) / len(data[key])) * 100, 2)


def median(data, key):
    return round(np.median(data[key]) * 100, 2)


names = OrderedDict({
    'solver': 'Solver-based',
    '50': 'Naive (50 recs)',
    '100': 'Naive (100 recs)',
    '300': 'Naive (300 recs)',
    '500': 'Naive (500 recs)',
    '1000': 'Naive (1000 recs)',
})


def construct_dataframe(data):
    framedata = []
    for key in ['solver', '50', '100', '300', '500', '1000']:
        for v in data[key]:
            framedata.append({
                'Value': round(v * 100, 2),
                'Mode': names[key],
            })
    return pd.DataFrame(framedata)


print('Average Naive (50 records)', avg(data, '50'))
print('Average Naive (100 records)', avg(data, '100'))
print('Average Naive (300 records)', avg(data, '300'))
print('Average Naive (500 records)', avg(data, '500'))
print('Average Naive (1000 records)', avg(data, '1000'))
print('Average Solver', avg(data, 'solver'))

print('Median Naive (50 records)', median(data, '50'))
print('Median Naive (100 records)', median(data, '100'))
print('Median Naive (300 records)', median(data, '300'))
print('Median Naive (500 records)', median(data, '500'))
print('Median Naive (1000 records)', median(data, '1000'))
print('Median Solver', median(data, 'solver'))

plt.style.use('ggplot')
sns.set(style="whitegrid")
plt.rcParams['font.family'] = 'DejaVu Sans'
plt.rcParams['figure.figsize'] = (8, 4)
plt.rcParams['axes.labelsize'] = 14
plt.rcParams['xtick.labelsize'] = 12
plt.rcParams['font.serif'] = 'DejaVu Sans'
plt.rcParams['font.monospace'] = 'Inconsolata Medium'
plt.rcParams['axes.labelweight'] = 'bold'
dataframe = construct_dataframe(data)
sns.boxplot(data=dataframe,
            width=0.5,
            y='Value', x='Mode', showfliers=False, showmeans=True,
            order=names.values(), color='gainsboro',
            meanprops={'marker': '^',
                       'markerfacecolor': 'black',
                       'markeredgecolor': 'black'}).set(
                xlabel='Data Generation Strategy',
                ylabel='Unsatisfied Queries (%)'
            )
plt.xticks(rotation=30)
plt.savefig("fig10.pdf", format='pdf', bbox_inches='tight',
            pad_inches=0)
