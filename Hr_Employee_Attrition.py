#!/usr/bin/env python
# coding: utf-8

# In[121]:


#importing packages

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder
from sklearn.linear_model import LogisticRegression
from sklearn.naive_bayes import GaussianNB,MultinomialNB
from sklearn.naive_bayes import BernoulliNB
from sklearn.tree import DecisionTreeClassifier
from sklearn.svm import SVC
from sklearn.ensemble import RandomForestClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score,confusion_matrix,classification_report
import warnings
warnings.filterwarnings('ignore')


# In[122]:


#reading the dataset
df=pd.read_csv('HR_Analytics.csv')
df.head()


# In[123]:


#checking datatype of each column
df.info()


# In[124]:


#describing numerical columns of dataset
df.describe()


# In[125]:


#rows are 1470 and columns are 35
df.shape


# In[126]:


df.isnull().sum().any()#checking null values are presernt or not


# In[127]:


#checking if any duplicate values are present or not
df.duplicated().sum()


# In[128]:


df.columns = df.columns.str.lower()
df.columns = df.columns.str.replace(' ','_')


# In[129]:


#column names of dataset
df.columns


# In[130]:


get_ipython().system('pip install psycopg2-binary sqlalchemy pandas')


# In[131]:


from sqlalchemy import create_engine


# In[132]:


# Connect to postgreSQL

username = "postgres"
password = "Ankita123"
host = "localhost"
port = "5432"
database = "Employee_Attrition"


engine = create_engine(f"postgresql+psycopg2://{username}:{password}@{host}:{port}/{database}")

# Load DataFrame into PostgreSQL

table_name = "employee"
df.to_sql(table_name, engine, if_exists='replace', index=False)

print(f"DataFrame loaded into PostgreSQL table: '{table_name}' in database '{database}'.")


# In[ ]:




