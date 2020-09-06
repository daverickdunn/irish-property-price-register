import pandas as pd
from scipy import stats
import numpy as np
import matplotlib.pyplot as plt

prices = pd.read_csv("C:/Users/Dave/Desktop/PPR/data/merged.csv", usecols=["Date", "Price"], parse_dates=['Date'], dayfirst=True, encoding="ISO-8859-1")

prices['Price'] = prices['Price'].str.replace(',', '')
prices['Price'] = prices['Price'].astype(float)
prices = prices[prices['Price'] <= 1000000.0]

Q1 = prices['Price'].quantile(0.25)
Q3 = prices['Price'].quantile(0.75)
IQR = Q3 - Q1
print(IQR)


# z = np.abs(stats.zscore(prices['Price']))
# print(z)
# prices['Price'] = prices['Price'][(z < 3).all(axis=1)]



per = prices.Date.dt.to_period("M")
mean = prices.groupby(per).mean().rename(columns={'Price':'Mean'})
median = prices.groupby(per).median().rename(columns={'Price':'Median'})
count = prices.groupby(per).count().mul(1000).rename(columns={'Price':'Count'})
combo = pd.concat([mean, median, count], axis=1)



print(combo)
combo.plot(y=['Mean', 'Median', 'Count'], style='-')
plt.show()